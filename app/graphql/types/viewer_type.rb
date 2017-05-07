Types::ViewerType = GraphQL::ObjectType.define do
  name "Viewer"

  field :id, !types.ID
  field :name, !types.String

  field :rooms do
    type !types[Types::RoomType]
    resolve -> (obj, args, ctx) { Room.all }
  end

  field :room do
    type Types::RoomType
    resolve -> (obj, args, ctx) { obj.room }
  end
end
