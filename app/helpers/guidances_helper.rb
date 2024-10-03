module GuidancesHelper
  def reading_heading(reading)
    content_tag(:div, :class => 'prompt_heading') do
      content_tag(:b, reading.to_s.titleize)
    end
  end

  def card_name_heading(card)
    content_tag(:div, :class => 'card_name') do
      content_tag(:b, card.name)
    end
  end

  def card_image(card)
    content_tag(:span) do
      image_tag card.image_url, class: "reminder"
    end
  end
  
  def reading_subheader(reading, date)
    content_tag(:span) do
      marketing_text('heading', 'member', reading, 'subheader').html_safe +
      content_tag(:em, date.strftime(" %B %e, %Y"))
    end
  end

  def carousel_reading(card, reading)
    content_tag(:div, :class => "wrapper") do
      content_tag(:div, :class => "owl-carousel owl-theme image-slider", :id => "Testcarousel") do
        card_image_paragraph(card) +
        simple_format(card.interpretations.where(reading: reading).last&.explanation)
      end
    end
  end

  def card_image_paragraph(card)
    content_tag(:p, :class => 'card_image_paragraph') do
      image_tag card.image_url, class: "pad reveal"
    end
  end

  def split_carousel_text(carousel_text)
    return [carousel_text] unless carousel_text.length > 620
    midpoint = carousel_text.length / 2
    split_point = carousel_text.index(' ', midpoint)
    first_half = carousel_text[0...split_point].strip 
    second_half = carousel_text[split_point..-1].strip
    return [first_half, second_half]
  end

  def show_carousel(carousel_text)
    split_carousel_text(carousel_text).each do |text|
      yield text unless text.strip.empty?
    end
  end
  
  def flipback box = nil
    func = box ? "flipBoxBack(event)" : "flipCardBack(event)"
    link_to "", '#', onclick: func, data: {turbolinks: false}, class: 'flipback'
  end
  
  def planet_description_display description
    content_tag(:div, :class => 'planet_description') do
      link_to('X', '#', :onclick => "$('.planet_description').remove(); return false", :class => 'planet_description_dismiss') +
      description.html_safe
    end
  end

  def subscribe_link
    if params[:source] == "cardsoflife"
      "https://www.thesourcecards.com/page/411520-cards-of-life/?ref=51028-The-Cards-of-Life"
    else
      "https://www.thesourcecards.com/page/447616-abundant-three-card-reading"
    end
  end
  
  def learn_subscribe
    "https://www.thesourcecards.com/page/411520-cards-of-life/?ref=51028-The-Cards-of-Life"
  end
  
  def subscribe_read_cards
    "https://www.thesourcecards.com/page/447616-abundant-three-card-reading"
  end
end
