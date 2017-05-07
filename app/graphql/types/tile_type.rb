Types::TileType = GraphQL::ObjectType.define do
  name "Tile"
  field :id, !types.ID
  field :kind, types.String
  field :order, types.Int
end
