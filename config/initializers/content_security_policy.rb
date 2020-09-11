SecureHeaders::Configuration.default do |config|
  config.csp = {
    frame_src: %w(lifeelevated.life thesourcecards.com)
    # default_src: %w('none'), # nothing allowed by default
    # script_src: %w(cdn.example.com),
    # connect_src: %w('self'),
    # img_src: %w(cdn.example.com data:),
    # font_src: %w(cdn.example.com data:),
    # base_uri: %w('self'),
    # style_src: %w('unsafe-inline' cdn.example.com),
    # form_action: %w('self'),
    # report_uri: %w(/mgmt/csp_reports)
  }
end
