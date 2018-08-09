module ApplicationHelper
  extend Memoist
  def marketing_text *keys
    copy = marketing_copy
    begin
      keys.each do |key|
        copy = copy[key]
      end
    rescue StandardError => error
      Rails.logger.info "Marketing text for #{keys} is not configured."
      copy = ''
    end
    if copy =~ /(ENV\[\'\w+\'\])/
      copy.gsub!($1, eval($1))
    end
    copy
  end
  
  def marketing_copy
    YAML.load(File.read(Rails.root.join('config', 'marketing.yml')))
  end
  
  def email_text *keys
    paragraphs = email_copy
    begin
      keys.each do |key|
        paragraphs = paragraphs[key]
      end
    rescue StandardError => error
      Rails.logger.info "Email text for #{keys} is not configured."
      paragraphs = []
    end
    copy = paragraphs.values.join "\n\n"
    if copy =~ /(ENV\[\'\w+\'\])/
      copy.gsub!($1, eval($1))
    end
    template = ERB.new copy
    template.result binding
  end
  
  def email_copy
    YAML.load(File.read(Rails.root.join('config', 'email_messaging.yml')))
  end
  memoize :marketing_copy, :email_copy
  
  def clearboth
    content_tag :div, '', :class => 'clearboth'
  end
  
  def clearleft
    content_tag :div, '', :class => 'clearleft'
  end
  
  def markdown
    @renderer ||= Redcarpet::Render::HTML.new
    @markdown ||= Redcarpet::Markdown.new @renderer
  end
  
  def mark_up content
    markdown.render(content.to_s).html_safe
  end
  
  def google_fonts
    content_tag :link, nil, :href => 'https://fonts.googleapis.com/css?family=Abel|Open+Sans+Condensed:300', :rel => 'stylesheet'
  end
end
