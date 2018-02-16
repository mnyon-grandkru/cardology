class Member < ApplicationRecord
  after_create :deliver_temporary_password
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  enum :zodiac_sign => [:aries, :taurus, :gemini, :cancer, :leo, :virgo, :libra, :scorpio, :sagittarius, :capricorn, :aquarius, :pisces]
  enum :subscription_status => [:active, :past_due, :canceled]
  belongs_to :birthday
  belongs_to :lookup
  
  def add_to_players_club_campaign
    client = GetResponse::Api.new
    traits = {
      :name => name,
      :email => email,
      :campaign => {:campaignId => ENV['GETRESPONSE_PLAYERS_CLUB_ID']},
      :customFieldValues => [{:customFieldId => ENV['GETRESPONSE_BIRTHDATE_ID'], :value => [birthday.birthdate_string]}]
    }
    client.contacts.create traits
  end
  
  def subscribed?
    ['active', 'past_due'].include? subscription_status
  end
  
  def subscription_past_due?
    subscription_status == 'past_due'
  end
  
  def verify_subscription_payments_current
    @customer = Braintree::Customer.find braintree_id
    subscriptions = Braintree::Subscription.search do |search|
      search.plan_id.is ENV['BRAINTREE_SUBSCRIPTION_PLAN']
    end
    
    member_subscriptions = subscriptions.select { |subscription| subscription.transactions.last.customer_details.id == @customer.id rescue nil }.compact
    if member_subscriptions.present?
      member_subscriptions.each do |subscription|
        update_attributes :subscription_status => subscription.status.parameterize.underscore
      end
    end
  end
  
  def account_age
    ((Time.now - created_at) / 1.day).floor
  end
  
  def self.generate_password
    ENV['INITIAL_PASSWORD']
  end
  
  def deliver_temporary_password
    MemberMailer.temporary_password(self).deliver
  end
end
