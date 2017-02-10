class Interpretation < ApplicationRecord
  belongs_to :card
  has_one :suit, :through => :card
  enum :reading => [:birth, :yearly]
  
  scope :of_suit, lambda { |suit_name| joins(:suit).where('suits.name' => suit_name) }
end
