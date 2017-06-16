Types::SeatType = GraphQL::ObjectType.define do
  name "Seat"

  field :position, !Types::WindType
  field :point, !types.Int
  field :river, !Types::RiverType
  field :hand, !Types::HandType
  field :user, !Types::UserType
end
