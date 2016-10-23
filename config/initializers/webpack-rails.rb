Rails.application.configure do
  config.webpack.dev_server.manifest_host = 'webpack'
  config.webpack.dev_server.manifest_port = 3808
  config.webpack.dev_server.enabled = ENV['CI'].blank?
end
