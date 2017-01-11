class Birthday < ApplicationRecord
  attr_accessor :date
  
  def name
    birthdate.strftime("%B %-d, %Y")
  end
  
  def birth_card
    deck = Card.ordered_deck.unshift(Card.find_by(:face => Face.find_by(:name => 'Joker')))
    position = month * 2 + day
    deck.reverse[54 - position]
  end

  def birthdate
    Date.new year, month, day
  end
  
  def age
    ((Date.today - birthdate) / (1.year / 1.day)).floor
  end
  
  def age_on_date date
    ((date - birthdate) / (1.year / 1.day)).floor
  end
  
  def days_since_birthday #including the birthday
    days_since_birthday_on_date Date.today
  end
  
  def days_since_birthday_on_date date
    today = Date.today
    if date.month > month
      last_birthday = Date.new date.year, month, day
    elsif date.month < month || date.day < day
      last_birthday = Date.new(date.year - 1, month, day)
    else
      last_birthday = Date.new date.year, month, day
    end
    day_before_birthday = last_birthday - 1
    (date - day_before_birthday).floor
  end
  
  def card_for_this_year
    card_for_the_year_on_date Date.today
  end
  
  def card_for_the_year_on_date date
    long_range_spread_index = age_on_date(date) / 7
    planetary_position = (age_on_date(date) % 7) + 1
    spread = Spread.find_by(:age => long_range_spread_index)
    position_of_birth_card = spread.position_of birth_card
    position = position_of_birth_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end
  
  def card_for_this_52_day_period
    card_for_the_planetary_period_on_date Date.today
  end
  
  def card_for_the_planetary_period_on_date date
    spread = Spread.find_by(:age => age_on_date(date))
    planetary_position = (days_since_birthday_on_date(date) / 52) + 1
    return Card.joker if planetary_position > 7
    position_of_birth_card = spread.position_of birth_card
    position = position_of_birth_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end
  
  def reading
    "Birth Card: #{birth_card.inspect}<br>This Year: #{card_for_this_year.inspect}<br>52-day Card: #{card_for_this_52_day_period.inspect}"
  end
end
