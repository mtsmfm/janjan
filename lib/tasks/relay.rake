namespace :graphql do
  task "schema:dump" => :environment do
    File.write(Rails.root.join("schema.json"), JSON.pretty_generate(GraphqlSchema.execute(GraphQL::Introspection::INTROSPECTION_QUERY)))
  end
end
