class Action::Start < Action::Base
  class << self
    def able?(user:, room:)
      room.users.count == 4 && (!room.game || room.game.end?)
    end

    def act!(user:, room:, params:)
      room.transaction do
        game = room.create_game!
        room.users.zip(Seat.positions.keys) do |u, p|
          game.seats.create!(user: u, position: p, point: 25000)
        end

        tiles = Tile.build_tiles

        game.seats.each do |seat|
          game.hands.create!(seat: seat, tiles: tiles.shift(13))
          game.rivers.create!(seat: seat)
        end

        game.create_wall!(tiles: tiles)

        create!(seat: user.seat, game: game)
      end
    end
  end
end
