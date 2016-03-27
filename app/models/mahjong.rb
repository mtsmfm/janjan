module Mahjong
  TILE_KINDS = YAML.load_file('config/tiles.yml')

  class << self
    def build_tiles
      (TILE_KINDS * 4).shuffle.map.with_index(1) do |kind, id|
        Tile.new(id: id, kind: kind)
      end
    end

    def create(users)
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

    def deal(board)
      tiles = build_tiles

      board.seats.sort_by(&:position).each do |seat|
        seat.hand.tiles  = tiles.shift(13)
        seat.river.tiles = []
        seat.available_actions =
          if seat.east?
            [Mahjong::Action::Draw.new(seat: seat, board: board)]
          else
            []
          end
      end
      board.wall = Field::Wall.new(tiles: tiles)
    end
  end

  class Wind
    WINDS = %i(east south west north)

    delegate :hash, :to_s, :to_sym, to: :@sym

    class << self
      def all
        WINDS.map {|w| new(w) }
      end
    end

    def initialize(sym)
      @sym = sym
    end

    def next
      self.class.new(WINDS.zip(WINDS.rotate).to_h[@sym])
    end

    def prev
      self.class.new(WINDS.zip(WINDS.rotate(-1)).to_h[@sym])
    end

    def eql?(other)
      hash == other.hash
    end

    def ==(other)
      eql?(other)
    end

    def as_json(*)
      to_s
    end

    def <=>(other)
      WINDS.index(to_sym) <=> WINDS.index(other.to_sym)
    end

    WINDS.each do |w|
      define_method("#{w}?") { @sym == w }
    end
  end

  module Field
    class Base
      include ActiveModel::Model
      include ActiveModel::Serialization

      attr_accessor :tiles
    end

    class Hand < Field::Base
      attr_accessor :user
    end

    class River < Field::Base
      attr_accessor :user
    end

    class Wall < Field::Base
    end
  end

  class Tile
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :id, :kind

    def order
      Mahjong::TILE_KINDS.index(kind)
    end
  end

  class Seat
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :position, :point, :river, :hand, :user, :available_actions

    delegate :east?, :south?, :west?, :north?, to: :position
  end

  class Board
    include ActiveModel::Model
    include ActiveModel::Serialization
    attr_accessor :seats, :wall, :wind, :round_number, :bonus_count

    delegate :east?, :south?, :west?, :north?, to: :wind
  end
end
