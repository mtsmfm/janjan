module Mahjong
  TILE_KINDS = YAML.load_file('config/tiles.yml')

  def self.build_tiles
    (TILE_KINDS * 4).shuffle.map.with_index(1) do |kind, id|
      Tile.new(id: id, kind: kind)
    end
  end

  def self.create(users)
    Board.new(wind: Wind.new(:east), round_number: 1, bonus_count: 0).tap do |board|
      board.seats = users.shuffle.zip(Wind.all).map {|user, pos|
        Seat.new(position: pos, point: 25000, user: user).tap do |seat|
          seat.hand  = Field::Hand.new(user: user, tiles: [])
          seat.river = Field::River.new(user: user, tiles: [])
        end
      }

      deal(board)
    end
  end

  def self.deal(board)
    tiles = build_tiles

    board.seats.sort_by(&:position).each do |seat|
      seat.hand.tiles  = tiles.shift(13)
      seat.river.tiles = []
      seat.available_actions =
        if seat.east?
          [Action::Draw.new(seat: seat, board: board)]
        else
          []
        end
    end
    board.wall = Field::Wall.new(tiles: tiles)
  end
end
