class GamesController < ApplicationController
  def show
    @game = Game.find_by!(id: params[:id], room_id: params[:room_id])
  end

  def create
    room = current_user.room

    raise unless room.ready_to_start_game?

    game = Game.new(room: room)

    room.transaction do
      game.save!
      room.users.zip(Seat.positions.keys) do |u, p|
        game.seats.create!(user: u, position: p, point: 25000)
      end

      tiles = Tile.build_tiles

      game.seats.each do |seat|
        game.hands.create!(seat: seat, tiles: tiles.shift(13))
        game.rivers.create!(seat: seat)
      end

      game.create_wall!(tiles: tiles)
    end

    redirect_to [room, game]
  end
end
