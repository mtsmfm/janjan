ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'pry-rescue/minitest' unless ENV['CI']

Dir[Rails.root.join('test/support/**')].each {|f| require f }

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures []

  # Add more helper methods to be used by all tests here...
end
