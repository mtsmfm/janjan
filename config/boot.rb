ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
ENV.delete('RAILS_ENV') if ENV.key?('RAILS_ENV') && ENV['RAILS_ENV'] == ''
ENV.delete('RACK_ENV')  if ENV.key?('RACK_ENV')  && ENV['RACK_ENV'] == ''

require 'bundler/setup' # Set up gems listed in the Gemfile.
