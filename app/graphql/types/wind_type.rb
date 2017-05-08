Types::WindType = GraphQL::EnumType.define do
  name "Wind"

  value :EAST
  value :SOUTH
  value :WEST
  value :NORTH
end
