module GuidancesHelper
  def card_box_pane(birthday,card, reading, date, position, planet = nil)
    reading_heading(reading, position) +
    content_tag(:div, :class => 'pane_guidance') do
      flipback('box') +
      pane_heading(birthday, card, reading, date, position, planet) +
      carousel_reading(card, reading) +
      temporal_navigation_buttons(reading, position) +
      copyright_text
    end
  end

  def pane_heading(birthday, card, reading, date, position, planet = nil)
    content_tag(:div, :class => 'constant') do
      card_name_heading(card) +
      content_tag(:div, :class => 'reading_context') do
        card_image(card) +
        reading_subheader(birthday, card, reading, date, position, planet)
      end
    end
  end

  def reading_heading(reading, position)
    content_tag(:div, :class => 'prompt_heading') do
      content_tag(:b, marketing_text('heading', 'member', reading, position.to_s, 'header'))
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

  def reading_text_handler(card, reading, birthday, position)
    if reading == 'planetary' && card.name == 'Joker'
      @joker = true
      if Date.current.leap?
        if birthday.day == Date.current.day + 1
          'second_joker'
        else
          'joker'
        end
      else
        'joker'
      end
    else
      @joker = false
      [position.to_s, 'subheader']
    end
  end
  
  def reading_subheader(birthday, card, reading, date, position, planet = nil)
    content_tag(:span) do
      marketing_text('heading', 'member', reading, *reading_text_handler(card, reading, birthday, position)).html_safe + +
      if reading == 'planetary'
        @joker ? "" : (planetary_link(planet, position) +
        content_tag(:em, planet_cycle_end_date(date)))
      elsif reading == 'yearly'
        tag(:br) + 
        content_tag(:em, birthday_range(date), :class => 'birthday_dates')
      else
        content_tag(:em, date.strftime(" %B %e, %Y"))
      end
    end
  end

  def birthday_range(birthday)
    birthday.strftime(" %B %e, %Y") + ' - ' + (birthday + 1.year - 1.day).strftime(" %B %e, %Y")
  end

  def planetary_link(planet, position)
    link_to planet, planet_guidance_path(planet, position), :remote => true
  end

  def planet_cycle_end_date(date)
    ".  This cycle ends on #{date.strftime("%-m/%-d.")}"
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

  def temporal_navigation_buttons(reading, position)
    content_tag(:div, :class => 'button_daily_card temporal_navigation') do
      if position == :back
        temporal_navigation_button(reading, 'return', 'rotateFuture(90)') +
        temporal_navigation_button(reading, 'forward', 'rotateFuture(360)')
      elsif position == :forward
        temporal_navigation_button(reading, 'backward', 'rotatePast(360)') +
        temporal_navigation_button(reading, 'return', 'rotatePast(90)')
      else
        temporal_navigation_button(reading, 'backward', 'rotateFuture(90)') +
        temporal_navigation_button(reading, 'forward', 'rotatePast(90)')
      end
    end
  end

  def temporal_navigation_button(reading, direction, rotation)
    link_to source_cards_marketing_text('temporal_navigation', reading, direction), '#', :onclick => "#{rotation}; return false;", :class => 'lunar_navigation', :data => {:turbolinks => false}
  end

  def copyright_text
    content_tag(:p, :class => 'copyright-txt') do
      "Copyright &copy; Alexander Dunlop".html_safe
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
