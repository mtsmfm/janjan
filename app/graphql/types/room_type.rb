RoomType = GraphQL::ObjectType.define do
  name "Room"

  field :id, !types.ID

  field :users do
    type types[UserType]
    description "Get all User"
    resolve -> (obj, args, ctx) { obj.users }
  end
end
