Types::RoomSubscribeType = GraphQL::ObjectType.define do
  name 'RoomSubscribe'

  field :mutation, !Types::MutationEnumType
  field :node, !Types::RoomType
end

Types::SubscriptionType = GraphQL::ObjectType.define do
  name 'Subscription'

  field :RoomSubscribe, Types::RoomSubscribeType
end
