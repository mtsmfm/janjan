Types::AvailableActionType = GraphQL::EnumType.define do
  name "AvailableAction"

  value :CONFIRM_GAME_END
  value :CONFIRM_ROUND_END
  value :DISCARD
  value :DRAW
  value :SELF_PICK
end
