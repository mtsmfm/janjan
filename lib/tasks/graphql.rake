namespace :graphql do
  task "schema:dump" => :environment do
    File.write(Rails.root.join("schema.graphql"), GraphqlSchema.to_definition)
  end
end
