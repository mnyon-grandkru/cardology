module DeliveriesHelper
  def source_card_url card
    "https://www.thesourcecards.com/" + card.name.gsub(' ', '-')
  end
end
