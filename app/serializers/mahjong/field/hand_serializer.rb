class Mahjong::Field::HandSerializer < ApplicationSerializer
  has_many :tiles

  def tiles
    object.user == current_user ? object.tiles : object.tiles.map {|t| Mahjong::Tile.new(id: t.id, kind: nil) }
  end
end
