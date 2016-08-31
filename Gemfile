source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', github: 'mtsmfm/rails', branch: 'use-log-method'
gem 'active_model_serializers'
gem 'bourbon'
gem 'coffee-rails'
gem 'em-hiredis'
gem 'haml-rails'
gem 'pg'
gem 'puma'
gem 'redis'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'uglifier'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem 'annotate'
  gem 'listen'
  gem 'rails-erd'
end

group :test do
  gem 'capybara'
  gem 'capybara-puma'
  gem 'database_rewinder'
  gem 'launchy'
  gem 'rspec-mocks'
  gem 'poltergeist'
  gem 'selenium-webdriver'
end

group :development, :test do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'tapp'
end
