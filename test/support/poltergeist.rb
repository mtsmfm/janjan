require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, phantomjs: Rails.root.join('node_modules/.bin/phantomjs').to_s, inspector: 'google-chrome-stable')
end
