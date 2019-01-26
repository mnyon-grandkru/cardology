class Celestial < ApplicationRecord
  belongs_to :birthday
  belongs_to :member
  
  def identifier
    name.present? ? name : birthday.name
  end
end
