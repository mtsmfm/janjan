module SubscriptionDatabase
  class << self
    # Part of the subscription API: put these subscriptions in the database
    def set(query, events)
      puts "Registering #{query.context[:channel]}"
      queries[query.context[:channel]] = query
      events.each do |ev|
        subscriptions[ev.key] << query
      end
    end

    # Part of the subscription API: load the query data for this channel
    def get(channel)
      query = queries[channel]
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
      subscriptions[event_key].each do |query|
        yield(query.context[:channel])
      end
    end

    # Not used by GraphQL, but the Application needs some way to unsubscribe
    # `Schema#subscriber` delegates to this, eg `MySchema.subscriber.delete(channel)`
    def delete(channel)
      queries.delete(channel)
      subscriptions.each do |event_key, queries|
        queries.reject! { |q| q.context[:channel] == channel }
      end
    end

    private

    def subscriptions
      @subscriptions ||= Hash.new { |h, event_id| h[event_id] = [] }
    end

    def queries
      @queries ||= {}
    end
  end
end

module StreamTransport
  class << self
    # Part of the subscription API: send `result` over `channel`.
    def deliver(channel, result, ctx)
      GraphqlChannel.broadcast_to(channel, result)
    end
  end
end

GraphqlSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
  subscription SubscriptionType
  use GraphQL::Subscriptions,
     transports: { "stream" => StreamTransport },
     store: SubscriptionDatabase
end
