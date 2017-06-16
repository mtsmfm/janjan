module GraphqlSubscriptionDatabase
  class ApplicationRecord < ::ApplicationRecord
    self.abstract_class = true
    self.table_name_prefix = :graphql_subscription_database_
  end

  class Stream < ApplicationRecord
    has_many :queries, dependent: :destroy, foreign_key: :graphql_subscription_database_stream_id
  end

  class Query < ApplicationRecord
    has_many :events, dependent: :destroy, foreign_key: :graphql_subscription_database_query_id
  end

  class Event < ApplicationRecord
  end

  class << self
    # Part of the subscription API: put these subscriptions in the database
    def set(query, events)
      Stream.transaction do
        query = Query.create!(
          graphql_subscription_database_stream_id: query.context[:channel],
          query_string: query.query_string,
          provided_variables: query.provided_variables,
          operation_name: query.operation_name
        )
        events.each do |ev|
          query.events.create!(key: ev.key)
        end
      end
    end

    # Part of the subscription API: load the query data for this channel
    def get(channel)
      query = Query.find_by!(graphql_subscription_database_stream_id: channel)
      {
        query_string: query.query_string,
        variables: query.provided_variables,
        context: {},
        operation_name: query.operation_name,
        transport: "stream",
      }
    end

    # Part of the subscription API: fetch subscriptions from the DB and yield them one-by-one
    def each_channel(event_key)
      Query.joins(:events).merge(Event.where(key: event_key)).each do |query|
        yield(query.graphql_subscription_database_stream_id)
      end
    end

    # Not used by GraphQL, but the Application needs some way to unsubscribe
    # `Schema#subscriber` delegates to this, eg `MySchema.subscriber.delete(channel)`
    def delete(channel)
      Stream.find(channel).destroy
    end
  end
end
