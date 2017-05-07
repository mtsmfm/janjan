require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Janjan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.active_record.schema_format = :sql

    config.generators do |g|
      g.stylesheets         nil
      g.javascripts         nil
      g.helper              nil
      g.template_engine     nil
      g.test_framework      nil
      g.fixture_replacement nil
    end

    binding.pry

    #config.autoload_paths << Rails.root.join("app", "graphql")
    #config.autoload_paths << Rails.root.join("app", "graphql", "fields")
    #config.autoload_paths << Rails.root.join("app", "graphql", "mutations")
    #config.autoload_paths << Rails.root.join("app", "graphql", "types")
    #config.autoload_paths << Rails.root.join("app", "graphql", "resolvers")
  end
end
