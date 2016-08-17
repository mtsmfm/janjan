require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Janjan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.schema_format = :sql

    config.generators do |g|
      g.stylesheets         false
      g.javascripts         false
      g.helper              false
      g.template_engine     false
      g.test_framework      false
      g.fixture_replacement false
    end
  end
end
