module ReadingsHelper
  def card_reading_pane card, reading, title, subtitle, side = 'front', &block
    div_for @birthday, "#{reading}_card_for", :class => "card_reading_pane pane #{side}" do
      content_tag(:header, title) +
      content_tag(:header, subtitle, :class => 'subtitle') +
      div_for(card, :identification_of) do
        div_for(card, :name_of) do
          card.name
        end +
        image_tag(card.image, :class => 'card_face_image')
      end +
      div_for(card, :explication_of) do
        mark_up interpretation_of(card, reading)
      end +
      if block_given?
        capture(&block)
      end
    end
  end
end
