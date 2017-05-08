Types::HandType = GraphQL::ObjectType.define do
  name "Hand"

  field :tiles, !types[Types::TileType]
end
