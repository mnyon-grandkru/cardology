class Spread < ApplicationRecord
  has_many :places
  
  def position_of card
    places.find_by :card_id => card.id
  end
  
  def quadrated_deck
    deck = Card.ordered_deck
    (age + 1).times { deck = quadrate deck }
    return deck
  end

  def self.life_spread
    Spread.find_by :age => 0
  end
  
  def quadrate deck
    hearts_pile = []
    clubs_pile = []
    diamonds_pile = []
    spades_pile = []
    
    4.times do
      hearts_pile << deck.pop(3)
      clubs_pile << deck.pop(3)
      diamonds_pile << deck.pop(3)
      spades_pile << deck.pop(3)
    end

    hearts_pile << deck.pop
    clubs_pile << deck.pop
    diamonds_pile << deck.pop
    spades_pile << deck.pop
    
    deck = hearts_pile.flatten + clubs_pile.flatten + diamonds_pile.flatten + spades_pile.flatten

    hearts_pile = []
    clubs_pile = []
    diamonds_pile = []
    spades_pile = []
    
    13.times do
      hearts_pile << deck.pop
      clubs_pile << deck.pop
      diamonds_pile << deck.pop
      spades_pile << deck.pop
    end
    
    deck = hearts_pile + clubs_pile + diamonds_pile + spades_pile
    return deck
  end
end
