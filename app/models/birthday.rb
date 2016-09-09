class Birthday < ApplicationRecord
  def birth_card
    deck = Card.ordered_deck.unshift(Card.find_by(:face => Face.find_by(:name => 'Joker')))
    position = month * 2 + day
    deck.reverse[54 - position]
  end

  def birthdate
    Date.new year, month, day
  end
  
  def age
    ((Date.today - birthdate) / 365).floor
  end
  
  def days_since_birthday
    today = Date.today
    if today.month > month
      last_birthday = Date.new today.year, month, day
    elsif today.month < month 
      last_birthday = Date.new(today.year - 1, month, day)
    elsif today.day < day
      last_birthday = Date.new(today.year - 1, month, day)
    else
      last_birthday = Date.new today.year, month, day
    end
    
    (today - last_birthday).floor
  end
  
  def card_for_this_year
    long_range_spread_index = age / 7
    planetary_position = (age % 7) + 1
    spread = Spread.find_by(:age => long_range_spread_index)
    position_of_birth_card = spread.position_of birth_card
    position = position_of_birth_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end
  
  def card_for_this_52_day_period
    spread = Spread.find_by(:age => age)
    planetary_position = (days_since_birthday / 52) + 1
    position_of_birth_card = spread.position_of birth_card
    position = position_of_birth_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end
end
