Types::GameType = GraphQL::ObjectType.define do
  name "Game"

  field :id, !types.ID
  field :wall, !Types::WallType
  field :seats, !types[Types::WallType]
  field :availableAtions, !types[Types::AvailableActionType]
end
