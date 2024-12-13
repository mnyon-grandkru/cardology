module WheelsHelper
  def wheel_rim cards, type
    content_tag :div, :class => "wheel-rim #{type}" do
      content_tag(:header, type.to_s.titleize) +
      cards.map do |card|
        content_tag :div, :class => "wheel-rim-card" do
          card.reading_extent.html_safe +
          image_tag(card.image_url, :class => "wheel-rim-card-image")
        end
      end.join.html_safe
    end
  end
end

# concat is used to add content to the buffer without starting a new tag
# content_tag is used to start a new tag and add content to it
