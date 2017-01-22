class Place < ApplicationRecord
  belongs_to :card
  belongs_to :spread
  
  def inspect
    "#{position} in Spread #{spread.age}"
  end
end
