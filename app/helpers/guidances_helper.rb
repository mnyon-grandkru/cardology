module GuidancesHelper
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
