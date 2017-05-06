payload_type = GraphQL::ObjectType.define do
  name "Payload"
  field :str, !types.String
end

SubscriptionType = GraphQL::ObjectType.define do
  name 'Subscription'

  field :test, payload_type
end
