class UserSerializer < ApplicationSerializer
  attributes :id, :name

  has_one :room, if: 'object.room'
  has_one :game, if: 'object.game'
end
