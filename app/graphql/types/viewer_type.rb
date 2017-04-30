ViewerType = GraphQL::ObjectType.define do
  name "Viewer"

  field :id, !types.ID
  field :name, !types.String

  field :users do
    type types[UserType]
    description "Get all User"
    resolve -> (obj, args, ctx) { User.all }
  end

  field :rooms do
    type types[RoomType]
    resolve -> (obj, args, ctx) { Room.all }
  end
end
