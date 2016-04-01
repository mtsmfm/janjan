module Mahjong
  class Board
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :seats, :wall, :wind, :round_number, :bonus_count

    delegate :east?, :south?, :west?, :north?, to: :wind
  end
end
