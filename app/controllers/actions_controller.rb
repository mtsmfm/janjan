class ActionsController < ApplicationController
  after_action :notify_action_created

  def create
  end

  def start
    room = current_user.room

    raise unless Action::Start.able?(user: current_user, room: room)

    room.transaction do
      game = room.create_game!
      room.users.zip(Seat.positions.keys) do |user, pos|
        game.seats.create!(position: pos, user: user, point: 25000)
      end

      tiles = Tile.build_tiles

      game.seats.each do |seat|
        game.hands.create!(seat: seat, tiles: tiles.shift(13))
        game.rivers.create!(seat: seat)
      end

      game.create_wall!(tiles: tiles)

      Action::Start.create!(seat: current_user.seat, game: game)
    end

    redirect_to room
  end

  def draw
    room = current_user.room
    game = room.game

    game.transaction do
      current_user.hand.tiles << game.wall.tiles.first

      Action::Draw.create!(seat: current_user.seat, game: game)
    end

    redirect_to room
  end

  def discard
    room = current_user.room
    game = room.game

    game.transaction do
      current_user.river.tiles << current_user.hand.tiles.find(params[:id])

      Action::Discard.create!(seat: current_user.seat, game: game)
    end

    redirect_to room
  end

  def self_pick
    room = current_user.room
    game = room.game

    game.transaction do
      Action::SelfPick.create!(seat: current_user.seat, game: game)
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
