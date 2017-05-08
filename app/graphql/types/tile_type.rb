Types::TileType = GraphQL::ObjectType.define do
  name "Tile"

  global_id_field :id
  field :kind, types.String
  field :order, types.Int
end
