class ActionsController < ApplicationController
  def create
  end

  def start
    raise if Action::Start.able?(user: current_user, room: room)

    room = current_user.room

    room.transaction do
      game = room.create_game!

      tiles = (Tile::KINDS * 4).shuffle.map do |kind|
        Tile.new(kind: kind)
      end

      room.users.each do |user|
        game.hands.create!(user: user, tiles: tiles.shift(13))
      end

      game.create_wall!(tiles: tiles)
    end

    render json: current_user.hand.tiles
  end
end
