module Celluloid
  class << self
    def register_shutdown
      # nop
    end
  end
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'
require 'capybara/poltergeist'
require 'pry-rescue/minitest' unless ENV['CI']

Dir[Rails.root.join('test/support/**')].each {|f| require f }

class ActiveSupport::TestCase
  self.use_transactional_tests = false
end

ActionDispatch::IntegrationTest.include(Capybara::DSL)

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 10

DatabaseRewinder.clean_all
