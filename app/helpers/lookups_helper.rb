module LookupsHelper
  def scrolling_view_of card_names
    content_tag :div, :class => 'scroller' do
      content_tag :div, :class => 'card_holder' do
        card_names.map do |card_name|
          content_tag :div, :class => 'card_reading' do
            preview_of_card card_name
          end
        end.join.html_safe
      end
    end
  end
  
  def preview_of_card card_name
    content_tag :div, :class => 'card_display' do
      [
        content_tag(:div, image_tag(Card.card_back_image, :class => 'preview_card'), :class => 'card_image'),
        content_tag(:div, "#{card_name.capitalize} Card", :class => 'card_name'),
        content_tag(:div, meaning_of_reading(card_name), :class => 'interpretation_description')
      ].join.html_safe
    end
  end
end
