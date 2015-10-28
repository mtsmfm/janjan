class ActionsController < ApplicationController
  def create
  end

  def start
    room = current_user.room

    raise unless Action::Start.able?(user: current_user, room: room)

    room.transaction do
      game = room.create_game!

      tiles = (Tile::KINDS * 4).shuffle.map do |kind|
        Tile.new(kind: kind)
      end

      room.users.each do |user|
        game.hands.create!(user: user, tiles: tiles.shift(13))
      end

      game.create_wall!(tiles: tiles)

      Action::Start.create!(user: current_user, game: game)
    end

    redirect_to room
  end
end
