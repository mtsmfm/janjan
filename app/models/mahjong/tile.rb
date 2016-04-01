module Mahjong
  class Tile
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :id, :kind

    def order
      Mahjong::TILE_KINDS.index(kind)
    end
  end
end
