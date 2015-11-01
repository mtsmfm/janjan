class ActionsController < ApplicationController
  after_action :notify_action_created

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
        game.rivers.create!(user: user)
      end

      game.create_wall!(tiles: tiles)

      Action::Start.create!(user: current_user, game: game)
    end

    redirect_to room
  end

  def draw
    room = current_user.room
    game = room.game

    game.transaction do
      current_user.hand.tiles << game.wall.tiles.first

      Action::Draw.create!(user: current_user, game: game)
    end

    redirect_to room
  end

  def discard
    room = current_user.room
    game = room.game

    game.transaction do
      current_user.river.tiles << current_user.hand.tiles.find(params[:id])

      Action::Discard.create!(user: current_user, game: game)
    end

    redirect_to room
  end

  private

  def notify_action_created
    (current_user.room.users - [current_user]).each do |user|
      ActionCable.server.broadcast "web_notifications_#{user.id}", {}
    end
  end
end
