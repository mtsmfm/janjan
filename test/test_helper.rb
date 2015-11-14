ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'
require 'pry-rescue/minitest' unless ENV['CI']

Dir[Rails.root.join('test/support/**')].each {|f| require f }

class ActiveSupport::TestCase
  self.use_transactional_tests = false
end

ActionDispatch::IntegrationTest.include(Capybara::DSL)

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :phantomjs do |app|
  Capybara::Selenium::Driver.new(app, browser: :phantomjs)
end

Capybara.javascript_driver = :phantomjs
