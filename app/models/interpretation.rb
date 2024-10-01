class Interpretation < ApplicationRecord
  belongs_to :card, :required => true
  has_one :suit, :through => :card
  has_one :face, :through => :card
  enum :reading => [:birth, :yearly, :personality, :daily, :planetary, :pluto]
  
  scope :of_suit, lambda { |suit_name| joins(:suit).where('suits.name' => suit_name) if suit_name }
  scope :of_reading, lambda { |reading_name| where :reading => reading_name if reading_name }
  scope :with_face, lambda { |face_value| joins(:face).where('cards.name' => face_value) }
  scope :by_face, lambda { joins(:face).order('faces.number') }
  paginates_per 5
end
