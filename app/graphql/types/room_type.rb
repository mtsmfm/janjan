Types::RoomType = GraphQL::ObjectType.define do
  name "Room"

  global_id_field :id

  field :users do
    type types[Types::UserType]
    description "Get all User"
    resolve -> (obj, args, ctx) { obj.users }
  end
  field :usersCount, !types.Int do
    resolve -> (obj, args, ctx) { obj.users.count }
  end
  field :game, Types::GameType do
    resolve -> (obj, args, ctx) { obj.game }
  end
end
