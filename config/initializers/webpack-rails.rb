Rails.application.configure do
  config.webpack.dev_server.manifest_host = 'webpack'
  config.webpack.dev_server.manifest_port = 3808
  config.webpack.dev_server.enabled = !Rails.env.production? && ENV['CI'].blank?
end
