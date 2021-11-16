module DeliveriesHelper
  def source_card_url card
    'https://www.thesourcecards.com/' + card.name.gsub(' ', '-')
  end
  
  def birthday_card_url birthday, card
    'https://www.thesourcecards.com/' + Date::MONTHNAMES[birthday.month] + '-' + birthday.day.ordinalize + '-birthday-' + card.numeric_name.gsub(' ', '-')
  end
end
