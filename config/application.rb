require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cardology
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # config.action_dispatch.default_headers["X-Content-Security-Policy"] = "FRAME-ANCESTORS https://*.lifeelevated.life";
    # config.action_dispatch.default_headers["Content-Security-Policy"] = "FRAME-ANCESTORS https://*.lifeelevated.life";
    # config.action_dispatch.default_headers["X-Frame-Options"] = "FRAME-ANCESTORS https://www.lifeelevated.life/";
    # config.action_dispatch.default_headers["Access-Control-Allow-Origin"] = "*";
    config.action_dispatch.default_headers.clear
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
