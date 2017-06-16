GraphqlSchema = GraphQL::Schema.define do
  query Types::QueryType
  mutation Types::MutationType
  subscription Types::SubscriptionType
  use GraphQL::Subscriptions,
     transports: { "stream" => GraphqlSubscriptionStreamTransport },
     store: GraphqlSubscriptionDatabase

  object_from_id ->(id, _ctx) {
    type_name, object_id = GraphQL::Schema::UniqueWithinType.decode(id)
    case type_name
    when "Room"
      Room.find(object_id)
    end
  }
  id_from_object ->(obj, type, _ctx) {
    GraphQL::Schema::UniqueWithinType.encode(
      type.name,
      obj.id
    )
  }
  resolve_type ->(obj, _ctx) { GraphQLSchema.types[obj.class.name] }
end
