class Member < ApplicationRecord
  after_create :deliver_temporary_password
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum :zodiac_sign => [:aries, :taurus, :gemini, :cancer, :leo, :virgo, :libra, :scorpio, :sagittarius, :capricorn, :aquarius, :pisces]
  
  belongs_to :birthday
  belongs_to :lookup
  
  def self.generate_password
    ENV['INITIAL_PASSWORD']
  end
  
  def deliver_temporary_password
    MemberMailer.temporary_password(self).deliver
  end
end
