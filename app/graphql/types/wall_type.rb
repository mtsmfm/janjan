WallType = GraphQL::ObjectType.define do
  name "Wall"

  field :tiles, !types[TileType]
end
