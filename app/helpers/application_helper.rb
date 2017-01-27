module ApplicationHelper
  def clearboth
    content_tag :div, :class => 'clearboth' do
      
    end
  end
  
  def markdown
    @renderer ||= Redcarpet::Render::HTML.new
    @markdown ||= Redcarpet::Markdown.new @renderer
  end
  
  def mark_up content
    markdown.render(content.to_s).html_safe
  end
  
  def google_fonts
    content_tag :link, nil, :href => 'https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300', :rel => 'stylesheet'
  end
end
