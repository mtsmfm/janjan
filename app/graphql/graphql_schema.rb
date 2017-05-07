GraphqlSchema = GraphQL::Schema.define do
  query Types::QueryType
  mutation Types::MutationType
  subscription Types::SubscriptionType
  use GraphQL::Subscriptions,
     transports: { "stream" => GraphqlSubscriptionStreamTransport },
     store: GraphqlSubscriptionDatabase
end
