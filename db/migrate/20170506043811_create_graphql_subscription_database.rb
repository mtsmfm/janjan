class CreateGraphqlSubscriptionDatabase < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto'

    create_table :graphql_subscription_database_streams, id: :uuid do |t|
      t.timestamps null: false
    end

    create_table :graphql_subscription_database_queries, id: :uuid do |t|
      t.references :graphql_subscription_database_stream, foreign_key: true, index: {name: :index_gsdb_queries_on_gsdb_stream_id}, null: false, type: :uuid
      t.string :query_string, null: false
      t.jsonb :provided_variables, null: false
      t.string :operation_name

      t.timestamps null: false
    end

    create_table :graphql_subscription_database_events, id: :uuid do |t|
      t.references :graphql_subscription_database_query, foreign_key: true, index: {name: :index_gsdb_events_on_gsdb_stream_id}, null: false, type: :uuid
      t.string :key, null: false

      t.timestamps null: false
    end
  end
end
