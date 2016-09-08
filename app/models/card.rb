class Card < ApplicationRecord
  belongs_to :suit
  belongs_to :face
  
  def self.ordered_deck
    deck = []
    ['Hearts', 'Clubs', 'Diamonds', 'Spades'].each do |suit_name|
      suit = Suit.find_by :name => suit_name
      ['Ace', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten', 'Jack', 'Queen', 'King'].each do |face_name|
        face = Face.find_by :name => face_name
        card = Card.find_by :suit => suit, :face => face
        deck << card
      end
    end
    return deck.reverse
  end
  
  def inspect
    "#{face.name} of #{suit.name}"
  end
end
