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
  
  def personality_card
    spread = Spread.find_by(:age => 0)
    position_of_birth_card = spread.position_of birth_card
    Rails.logger.info "Position of birth card: #{position_of_birth_card}"
    Rails.logger.info "Number for planet: #{number_for_planet}"
    planetary_ruling_position = position_of_birth_card.position - number_for_planet
    place = Place.find_by :spread_id => spread.id, :position => planetary_ruling_position
    place.card
  end
  
  def astrological_sign
    case birthdate.month
    when 1
      case birthdate.day
      when 1..20
        :capricorn
      when 21..22
        cusp(:capricorn, :aquarius)
      when 23..31
        :aquarius
      end
    when 2
      case birthdate.day
      when 1..20
        :aquarius
      when 21..22
        cusp(:aquarius, :pisces)
      when 23..31
        :pisces
      end
    when 3
      case birthdate.day
      when 1..20
        :pisces
      when 21..22
        cusp(:pisces, :aries)
      when 23..31
        :aries
      end
    when 4
      case birthdate.day
      when 1..20
        :aries
      when 21..22
        cusp(:aries, :taurus)
      when 23..31
        :taurus
      end
    when 5
      case birthdate.day
      when 1..20
        :taurus
      when 21..22
        cusp(:taurus, :gemini)
      when 23..31
        :gemini
      end
    when 6
      case birthdate.day
      when 1..20
        :gemini
      when 21..22
        cusp(:gemini, :cancer)
      when 23..31
        :cancer
      end
    when 7
      case birthdate.day
      when 1..20
        :cancer
      when 21..22
        cusp(:cancer, :leo)
      when 23..31
        :leo
      end
    when 8
      case birthdate.day
      when 1..20
        :leo
      when 21..22
        cusp(:leo, :virgo)
      when 23..31
        :virgo
      end
    when 9
      case birthdate.day
      when 1..20
        :virgo
      when 21..22
        cusp(:virgo, :libra)
      when 23..31
        :libra
      end
    when 10
      case birthdate.day
      when 1..20
        :libra
      when 21..22
        cusp(:libra, :scorpio)
      when 23..31
        :scorpio
      end
    when 11
      case birthdate.day
      when 1..20
        :scorpio
      when 21..22
        cusp(:scorpio, :saggitarius)
      when 23..31
        :saggitarius
      end
    when 12
      case birthdate.day
      when 1..20
        :saggitarius
      when 21..22
        cusp(:saggitarius, :capricorn)
      when 23..31
        :capricorn
      end
    end
  end
  
  def cusp leader, follower
    leader
  end
  
  def planet_for_sign
    case astrological_sign
    when :aries
      :mars
    when :taurus
      :venus
    when :gemini
      :mercury
    when :cancer
      :moon
    when :leo
      :sun
    when :virgo
      :mercury
    when :libra
      :venus
    when :scorpio
      :mars
    when :saggitarius
      :jupiter
    when :capricorn
      :saturn
    when :aquarius
      :saturn
    when :pisces
      :jupiter
    end
  end
  
  def number_for_planet
    case planet_for_sign
    when :mercury
      1
    when :venus
      2
    when :mars
      3
    when :jupiter
      4
    when :saturn
      5
    when :neptune
      6
    when :uranus
      7
    when :pluto
      8
    when :sun
      9 # speculation
    when :moon
      10 # speculation
    end
  end
  
  def reading
    "Birth Card: #{birth_card.inspect}<br>This Year: #{card_for_this_year.inspect}<br>52-day Card: #{card_for_this_52_day_period.inspect}"
  end
end
