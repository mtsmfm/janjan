Types::WallType = GraphQL::ObjectType.define do
  name "Wall"

  field :tiles, !types[Types::TileType]
end
