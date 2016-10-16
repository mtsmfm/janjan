source 'https://rubygems.org'

ruby '2.3.1'

Bundler::Source::Git::GitProxy.prepend(Module.new do
  def git_retry(command)
    if command.start_with?('clone')
      command += " --depth 1 --branch #{ref}"
    end

    super(command)
  end
end)

gem 'rails', git: 'https://github.com/mtsmfm/rails', branch: 'use-log-method'
gem 'active_model_serializers'
gem 'bourbon'
gem 'coffee-rails'
gem 'committee'
gem 'em-hiredis'
gem 'haml-rails'
gem 'pg'
gem 'puma'
gem 'redis'
gem 'sass-rails', git: 'https://github.com/rails/sass-rails'
gem 'tenpai_wakaru_man'
gem 'uglifier'

group :development do
  gem 'annotate'
  gem 'listen'
  gem 'rails-erd'
  gem 'swagger2hyperschema'
end

group :test do
  gem 'capybara'
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
