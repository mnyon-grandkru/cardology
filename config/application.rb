require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cardology
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_dispatch.default_headers["X-Content-Security-Policy"] = "frame-ancestors http://*.lifeelevated.life";
    config.action_dispatch.default_headers["Content-Security-Policy"] = "frame-ancestors http://*.lifeelevated.life";
    config.action_dispatch.default_headers["X-Frame-Options"] = "frame-ancestors http://*.lifeelevated.life";
  end
end
