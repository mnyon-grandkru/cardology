class Member < ApplicationRecord
  after_create :deliver_temporary_password
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum :zodiac_sign => [:aries, :taurus, :gemini, :cancer, :leo, :virgo, :libra, :scorpio, :sagittarius, :capricorn, :aquarius, :pisces]
  enum :subscription_status => [:active, :overdue, :cancelled]
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
    subscription_status == 'active'
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
