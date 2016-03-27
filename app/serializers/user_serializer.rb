class UserSerializer < ApplicationSerializer
  attributes :id, :name

  has_one :room
  has_one :game
end
