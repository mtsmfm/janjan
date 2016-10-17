url = "http://#{ENV['BS_USERNAME']}:#{ENV['BS_AUTHKEY']}@hub.browserstack.com/wd/hub"

Capybara.register_driver :browserstack do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities['project'] = ENV['BS_AUTOMATE_PROJECT'] if ENV['BS_AUTOMATE_PROJECT']
  capabilities['build'] = ENV['BS_AUTOMATE_BUILD'] if ENV['BS_AUTOMATE_BUILD']
  capabilities['browser'] = 'chrome'
  capabilities['browser_version'] = '54 Beta'
  capabilities['browserstack.debug'] = true
  capabilities['browserstack.local'] = true

  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: capabilities)
end
