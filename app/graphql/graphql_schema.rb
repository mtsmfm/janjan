GraphqlSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
  subscription SubscriptionType
  use GraphQL::Subscriptions,
     transports: { "stream" => GraphqlSubscriptionStreamTransport },
     store: GraphqlSubscriptionDatabase
end
