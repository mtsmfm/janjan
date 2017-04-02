Rails.application.configure do
  config.webpack.dev_server.host = 'client' if Rails.env.test?
  config.webpack.dev_server.manifest_host = 'client'
  config.webpack.dev_server.manifest_port = 3808
  config.webpack.dev_server.enabled = !Rails.env.production? && ENV['CI'].blank?
end
