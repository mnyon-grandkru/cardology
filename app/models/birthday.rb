Cusp = Struct.new(:leader, :follower, :is_cusp?)
class Birthday < ApplicationRecord
  has_many :members
  has_many :celestials
  attr_accessor :date, :zodiac_sign
  
  def name
    birthdate.strftime("%B %-d, %Y")
  end
  
  def month_day
    birthdate.strftime("%B %-d")
  end
  
  def birthdate_string
    birthdate.strftime("%Y-%m-%d")
  end
  
  def birth_card
    deck = Card.ordered_deck.unshift(Card.find_by(:face => Face.find_by(:name => 'Joker')))
    position = month * 2 + day
    deck.reverse[54 - position]
  end

  def birthdate
    Date.new year, month, day
  end
  
  def actual_age_on_date date
    if (date.month == birthdate.month && date.day == birthdate.day)
      date.year - birthdate.year
    else
      ((date - birthdate) / (1.year.to_f / 1.day.to_f)).floor
    end
  end
  
  def age_on_date date
    actual_age = actual_age_on_date date
    if actual_age > 89
      actual_age - 90
    elsif actual_age < 0
      90 + actual_age
    else
      actual_age
    end
  end
  
  def age
    actual_age_on_date Date.current
  end
  
  def days_since_birthday #including the birthday
    days_since_birthday_on_date Date.current
  end
  
  def days_since_birthday_on_date date
    today = Date.current
    if date.month > month
      last_birthday = Date.new date.year, month, day
    elsif date.month < month || date.day < day
      last_birthday = Date.new(date.year - 1, month, day)
    else
      last_birthday = Date.new date.year, month, day
    end
    (date - last_birthday).floor
  end
  
  def days_since_birth_on_date date
    date - birthdate
  end
  
  def weeks_since_birth_on_date date
    days_since_birth_on_date(date) / 7
  end
  
  def position_in_week_on_date date
    (days_since_birth_on_date(date) % 7) + 1
  end
  
  def card_for_today main_card = birth_card
    card_for_date Date.current, main_card
  end
  
  def card_for_tomorrow main_card = birth_card
    card_for_date Date.tomorrow, main_card
  end
  
  def card_for_yesterday main_card = birth_card
    card_for_date Date.yesterday, main_card
  end
  
  def card_for_date date, main_card = birth_card
    return Card.joker if birth_card == Card.joker
    spread_ordinal = weeks_since_birth_on_date(date) % 90
    spread = Spread.find_by(:age => spread_ordinal)
    position_of_main_card = spread.position_of main_card
    position = position_of_main_card.position - position_in_week_on_date(date)
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end

  def daily_cards_for_year_and_month year, month
    (1..31).map do |day|
      card = card_for_date Date.new(year, month, day), birth_card
      card.reading_type = :daily
      card.start_date = Date.new(year, month, day)
      card
    end
  end
  
  def card_for_this_year main_card = birth_card
    card_for_the_year_on_date Date.current, main_card
  end
  
  def card_for_last_year main_card = birth_card
    card_for_the_year_on_date Date.current - 1.year, main_card
  end
  
  def card_for_next_year main_card = birth_card
    card_for_the_year_on_date Date.current + 1.year, main_card
  end
  
  def card_for_the_year_on_date date, main_card = birth_card
    return Card.joker if birth_card == Card.joker
    long_range_spread_index = age_on_date(date) / 7
    planetary_position = (age_on_date(date) % 7) + 1
    spread = Spread.find_by(:age => long_range_spread_index)
    position_of_main_card = spread.position_of main_card
    position = position_of_main_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end

  def year_cards
    (0..60).map do |i|
      card = card_for_the_year_on_date birthdate + i.years
      card.reading_type = :yearly
      card.start_date = birthdate + i.years
      card
    end
  end
  
  def ruling_card_for_the_year_on_date date
    card_for_the_year_on_date date, personality_card
  end
  
  def card_for_this_planet main_card = birth_card
    card_for_the_planetary_period_on_date Date.current, main_card
  end
  
  def card_for_last_planet main_card = birth_card
    card_for_the_planetary_period_on_date Date.current - 52.days, main_card
  end
  
  def card_for_next_planet main_card = birth_card
    card_for_the_planetary_period_on_date Date.current + 52.days, main_card
  end

  def card_for_previous_planet main_card = birth_card, planet = previous_planet_sym, year = Date.current
    card_for_planet planet, main_card, year
  end

  def card_for_upcoming_planet main_card = birth_card, planet = upcoming_planet_sym, year = Date.current
    card_for_planet planet, main_card, year
  end
  
  def days_until_next_planet
    days_since_bday = days_since_birthday
    if days_since_bday >= (52 * 7)
      next_birthday - Date.current
    else
      52 - (days_since_birthday % 52)
    end
  end
  
  def date_of_next_planet
    Date.current + days_until_next_planet.days
  end
  
  def last_birthday
    birthday_year = if Date.current.month > month
      Date.current.year
    elsif Date.current.month == month
      if Date.current.day >= day
        Date.current.year
      else
        Date.current.year - 1
      end
    else
      Date.current.year - 1
    end
    Date.civil birthday_year, month, day
  end
  
  def next_birthday
    last_birthday + 1.year
  end

  def previous_birthday
    last_birthday - 1.year
  end
  
  def dates_of_planetary_shifts birthday_for_year
    [
      birthday_for_year,
      birthday_for_year + 52.days,
      birthday_for_year + (52*2).days,
      birthday_for_year + (52*3).days,
      birthday_for_year + (52*4).days,
      birthday_for_year + (52*5).days,
      birthday_for_year + (52*6).days,
      birthday_for_year + (52*7).days,
      birthday_for_year + ((52*7) + 1).days
    ]
  end

  def conclusions_of_planets bday = last_birthday
    conclusions = {}
    dates = dates_of_planetary_shifts bday
    planets.each_with_index do |planet, index|
      conclusions[planet] = dates[index + 1]
    end
    conclusions
  end

  def planets
    planet_indices.keys
  end
  
  def transition_message date
    card_for_the_planetary_period_on_date(date) +
    ' in ' +
    planet_on_date(date)
  end
  
  def planetary_period_on_date date
    (days_since_birthday_on_date(date) / 52) + 1
  end
  
  def planet_on_date date
    planet_on_date_sym(date).to_s.capitalize
  end

  def planet_on_date_sym date
    planet_indices.invert[planetary_period_on_date date]
  end
  
  def current_planet_sym
    planet_on_date_sym Date.current
  end

  def previous_planet_sym current = current_planet_sym
    position = planets_for_52.index(current)
    planets_for_52[position - 1]
  end

  def conclusion_of_previous current = current_planet_sym, birthday = last_birthday
    conclusions_of_planets(birthday)[previous_planet_sym(current)]
  end

  def conclusion_of_upcoming current = current_planet_sym, birthday = last_birthday
    conclusions_of_planets(birthday)[upcoming_planet_sym(current)]
  end

  def previous_planet_name current = current_planet_sym
    previous_planet_sym(current).to_s.capitalize
  end

  def upcoming_planet_sym current = current_planet_sym
    position = planets_for_52.index(current)
    planets_for_52[(position + 1) % planets_for_52.length] # need to wrap around from last to Mercury
  end

  def upcoming_planet_name current = current_planet_sym
    upcoming_planet_sym(current).to_s.capitalize
  end

  def current_planet
    planet_on_date Date.current
  end
  
  def last_planet
    planet_on_date Date.current - 52.days
  end
  
  def next_planet
    planet_on_date Date.current + 52.days
  end

  def card_for_planet planet, main_card = birth_card, date = Date.current
    planetary_position = number_for_planet planet
    return Card.joker if planetary_position > 7 || main_card == Card.joker
    spread = Spread.find_by(:age => age_on_date(date))
    position_of_main_card = spread.position_of main_card
    position = position_of_main_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end
  
  def card_for_the_planetary_period_on_date date, main_card = birth_card
    return Card.joker if birth_card == Card.joker
    spread = Spread.find_by(:age => age_on_date(date))
    planetary_position = planetary_period_on_date date
    return Card.joker if planetary_position > 7
    position_of_main_card = spread.position_of main_card
    position = position_of_main_card.position - planetary_position
    position = 52 + position if position < 0
    place = Place.find_by :spread_id => spread.id, :position => position
    place.card
  end

  def planetary_cards
    (0..60).map do |year|
      (0..6).map do |planet|
        card = card_for_the_planetary_period_on_date birthdate + year.years + (planet * 52).days
        card.reading_type = :planetary
        card.start_date = birthdate + year.years + (planet * 52).days
        card
      end
    end.flatten
  end
  
  def ruling_card_for_the_planetary_period_on_date date
    card_for_the_planetary_period_on_date date, personality_card
  end
  
  def ruling_card_for_the_date date
    card_for_date date, personality_card
  end
  
  def personality_card
    return Card.joker if birth_card == Card.joker
    return nil if astrological_sign.is_cusp?
    spread = Spread.find_by :age => 0
    position_of_birth_card = spread.position_of birth_card
    planetary_ruling_position = position_of_birth_card.position - number_for_planet(planet_for_sign(astrological_sign))
    planetary_ruling_position = 52 + planetary_ruling_position if planetary_ruling_position < 0
    place = Place.find_by :spread_id => spread.id, :position => planetary_ruling_position
    place.card
  end
  
  def astrological_sign
    zodiac_sign || zodiac_for_birthday
  end
    
  def zodiac_for_birthday
    case birthdate.month
    when 1
      case birthdate.day
      when 1..19
        :capricorn
      when 20..21
        cusp(:capricorn, :aquarius)
      when 22..31
        :aquarius
      end
    when 2
      case birthdate.day
      when 1..18
        :aquarius
      when 19..20
        cusp(:aquarius, :pisces)
      when 21..29
        :pisces
      end
    when 3
      case birthdate.day
      when 1..19
        :pisces
      when 20..21
        cusp(:pisces, :aries)
      when 22..31
        :aries
      end
    when 4
      case birthdate.day
      when 1..19
        :aries
      when 20..21
        cusp(:aries, :taurus)
      when 22..30
        :taurus
      end
    when 5
      case birthdate.day
      when 1..19
        :taurus
      when 20..21
        cusp(:taurus, :gemini)
      when 22..31
        :gemini
      end
    when 6
      case birthdate.day
      when 1..20
        :gemini
      when 21..22
        cusp(:gemini, :cancer)
      when 23..30
        :cancer
      end
    when 7
      case birthdate.day
      when 1..21
        :cancer
      when 22..23
        cusp(:cancer, :leo)
      when 24..31
        :leo
      end
    when 8
      case birthdate.day
      when 1..21
        :leo
      when 22..23
        cusp(:leo, :virgo)
      when 24..31
        :virgo
      end
    when 9
      case birthdate.day
      when 1..21
        :virgo
      when 22..23
        cusp(:virgo, :libra)
      when 24..30
        :libra
      end
    when 10
      case birthdate.day
      when 1..22
        :libra
      when 23..24
        cusp(:libra, :scorpio)
      when 23..31
        :scorpio
      end
    when 11
      case birthdate.day
      when 1..20
        :scorpio
      when 21..22
        cusp(:scorpio, :sagittarius)
      when 23..30
        :sagittarius
      end
    when 12
      case birthdate.day
      when 1..20
        :sagittarius
      when 21..22
        cusp(:sagittarius, :capricorn)
      when 23..31
        :capricorn
      end
    end
  end
  
  def cusp leader, follower
    Cusp.new(leader, follower, true)
  end
  
  def planet_for_sign sign
    case sign
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
    when :sagittarius
      :jupiter
    when :capricorn
      :saturn
    when :aquarius
      :uranus
    when :pisces
      :neptune
    end
  end
  
  def planet_indices
    {
      :mercury => 1,
      :venus => 2,
      :mars => 3,
      :jupiter => 4,
      :saturn => 5,
      :uranus => 6,
      :neptune => 7,
      :pluto => 8,
      :sun => 0,
      :moon => -1
    }
  end

  def planets_for_52
    [:mercury, :venus, :mars, :jupiter, :saturn, :uranus, :neptune, :pluto]
  end
  
  def number_for_planet planet
    planet_indices[planet]
  end
  
  def reading
    "Birth Card: #{birth_card.inspect}<br>This Year: #{card_for_this_year.inspect}<br>52-day Card: #{card_for_this_planet.inspect}"
  end
  
  PLANETS = ['Mercury', 'Venus', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune']
  
  def triples_for_year
    triples = []
    dates_of_planetary_shifts(last_birthday).each_with_index do |date, index|
      triples << [date, PLANETS[index], card_for_the_planetary_period_on_date(date)]
    end
    dates_of_planetary_shifts(next_birthday).each_with_index do |date, index|
      triples << [date, PLANETS[index], card_for_the_planetary_period_on_date(date)]
    end
    triples
  end
  
  def calendar_string
    triples_for_year.map do |date, planet, card|
      "Move to #{card.name} in #{planet} on #{date.strftime("%B %-d")}"
    end.join(".\n")
  end

  def seven_year_cards
    life_spread = Spread.life_spread
    birth_card_position = life_spread.position_of(birth_card).position
    (1..13).map do |i|
      position = (birth_card_position - i) % 52
      card = life_spread.places.find_by(:position => position).card
      card.reading_type = :seven_year
      card.start_date = birthdate + (7 * (i - 1)).years
      card
    end
  end

  def thirteen_year_cards
    life_spread = Spread.life_spread
    birth_card_position = life_spread.position_of(birth_card).position
    (1..13).map do |i|
      position = (birth_card_position - i) % 52
      card = life_spread.places.find_by(:position => position).card
      card.reading_type = :thirteen_year
      card.start_date = birthdate + (13 * (i - 1)).years
      card
    end
  end

  def current_seven_year_period

  end

  def current_thirteen_year_period

  end

  def seven_year_period_for_date date

  end

  def thirteen_year_period_for_date date

  end

  def seven_year_periods

  end

  def thirteen_year_periods

  end
  
  memoize :birth_card, :personality_card
end

class Symbol
  def is_cusp?
    false
  end
end
