module Mahjong
  class Seat
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :position, :point, :river, :hand, :user, :available_actions

    delegate :east?, :south?, :west?, :north?, to: :position
  end
end
