Types::RoomSubscribeType = GraphQL::ObjectType.define do
  name 'roomSubscribe'

  field :mutation, !Types::MutationEnumType
  field :node, !Types::RoomType
end

Types::SubscriptionType = GraphQL::ObjectType.define do
  name 'Subscription'

  field :roomSubscribe, Types::RoomSubscribeType
end
