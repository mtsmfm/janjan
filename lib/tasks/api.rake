require 'yaml'

namespace :api do
  desc 'Build api schema'
  task 'schema:build' do
    swagger = YAML.load_file('schemata/api.yml')
    swagger['definitions'] = Dir['schemata/definitions/**/*.yml'].each.with_object({}) {|f, h| h.merge!(YAML.load_file(f)) }
    File.write('swagger.yml', swagger.to_yaml)

    sh 'swagger2hyperschema swagger.yml > schema.json'
  end
end
