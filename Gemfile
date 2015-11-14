source 'https://rubygems.org'

if ENV['CUSTOM_RUBY_VERSION']
  ruby ENV['CUSTOM_RUBY_VERSION']
else
  ruby '2.2.3'
end

gem 'rails', github: 'rails/rails'

gem 'actioncable', github: 'rails/actioncable'
gem 'arel', github: 'rails/arel'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'rack', github: 'rack/rack'
gem 'sass-rails'
gem 'uglifier'

group :development do
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'capybara-puma'
  gem 'connection_pool'
  gem 'launchy'
  gem 'mocha'
  gem 'selenium-webdriver'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'tapp'
end
