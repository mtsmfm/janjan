source 'https://rubygems.org'

if ENV['CUSTOM_RUBY_VERSION']
  ruby ENV['CUSTOM_RUBY_VERSION']
else
  ruby '2.2.3'
end

gem 'rails', '4.2.4'

gem 'actioncable', github: 'rails/actioncable'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'uglifier'

group :development do
  gem 'spring'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'
end
