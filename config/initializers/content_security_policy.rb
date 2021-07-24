# SecureHeaders::Configuration.default do |config|
#   config.csp = {
#     default_src: %w('*'),
#     script_src: SecureHeaders::OPT_OUT,
#     frame_src: %w(https://lifeelevated.life https://thesourcecards.com),
#     style_src: %w('unsafe-inline' 'self'),
#     # connect_src: %w('self'),
#     # img_src: %w(cdn.example.com data:),
#     # font_src: %w(cdn.example.com data:),
#     # base_uri: %w('self'),
#     # style_src: %w('unsafe-inline' cdn.example.com),
#     # form_action: %w('self'),
#     # report_uri: %w(/mgmt/csp_reports)
#   }
# end
