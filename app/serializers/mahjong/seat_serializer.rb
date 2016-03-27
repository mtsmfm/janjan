module Mahjong
  class SeatSerializer < ApplicationSerializer
    attributes :position, :point

    belongs_to :user
    has_one :river
    has_one :hand

    def position
      object.position.to_s
    end
  end
end
