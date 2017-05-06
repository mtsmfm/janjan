RoomSubscribeType = GraphQL::ObjectType.define do
  name 'RoomSubscribe'

  field :mutation, !MutationEnumType
  field :node, !RoomType
end

SubscriptionType = GraphQL::ObjectType.define do
  name 'Subscription'

  field :RoomSubscribe, RoomSubscribeType
end
