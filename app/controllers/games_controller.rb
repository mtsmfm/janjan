class GamesController < ApplicationController
  def show
    @game = Game.find_by!(id: params[:id], room_id: params[:room_id])
    @round = @game.rounds.last
  end

  def create
    room = current_user.room

    raise unless room.ready_to_start_game?

    game = Game.new(room: room)

    room.transaction do
      game.save!
      round = game.rounds.create!

      room.users.zip(Seat.positions.keys) do |u, p|
        round.seats.create!(user: u, position: p, point: 25000)
      end

      tiles = Tile.build_tiles

      round.seats.each do |seat|
        round.hands.create!(seat: seat, tiles: tiles.shift(13))
        round.rivers.create!(seat: seat)
      end

      round.create_wall!(tiles: tiles)
    end

    redirect_to [room, game]
  end
end
