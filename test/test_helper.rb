ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'pry-rescue/minitest' unless ENV['CI']

Dir[Rails.root.join('test/support/**')].each {|f| require f }

class ActiveSupport::TestCase
  self.use_transactional_tests = false
end

Capybara.default_driver = Capybara.javascript_driver = if ENV['CI']
  :browserstack
else
  :chrome
end

DatabaseRewinder.clean_all
