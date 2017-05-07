GameType = GraphQL::ObjectType.define do
  name "Game"

  field :id, !types.ID
  field :wall, !WallType
  field :seats, !types[WallType]
  field :availableAtions, !types[AvailableActionType]
end
