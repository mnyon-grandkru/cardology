class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  enum :zodiac_sign => [:aries, :taurus, :gemini, :cancer, :leo, :virgo, :libra, :scorpio, :sagittarius, :capricorn, :aquarius, :pisces]
  
  belongs_to :birthday
  belongs_to :lookup
  
  def self.generate_password
    'dinklage'
  end
end
