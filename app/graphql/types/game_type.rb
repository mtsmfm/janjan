Types::GameType = GraphQL::ObjectType.define do
  name "Game"

  global_id_field :id

  field :wall, !Types::WallType
  field :seats, !types[Types::WallType]
  field :availableAtions, !types[Types::AvailableActionType]
end
