module CardsHelper
  def card_preview reading
    content_tag :div, :id => "#{reading}_card_preview", :class => 'pane card_preview' do
      div_for(Card.last, :identification_of) do
        image_tag(Card.send("#{reading}_card_back_image"), :class => 'card_face_image') +
        div_for(Card.last, :opportunities_on) do
          "#{marketing_text 'book', 'question'} #{link_to(marketing_text('book', 'answer'), ENV['BOOK_PURCHASE_LINK'], :target => '_blank')}".html_safe
        end
      end +
      content_tag(:header, marketing_text('card_previews', 'member', reading.to_s, 'header'), :class => 'preview_header', :id => "#{reading}_preview_header") +
      div_for(Card.last, :explication_of) do
        mark_up marketing_text('card_previews', 'member', reading.to_s, 'description')
      end
    end
  end
  
  def cards_in_life_spread
    [
      :moon,
      :birth,
      :mercury,
      :venus,
      :mars,
      :jupiter,
      :saturn,
      :uranus,
      :neptune,
      :pluto,
      :abundance,
      :freedom,
      :excellence,
      :magician
    ]
  end
  
  def cards_in_year_spread
    [
      :mercury,
      :venus,
      :mars,
      :jupiter,
      :saturn,
      :uranus,
      :neptune,
      :pluto,
      :result
    ]
  end
end
