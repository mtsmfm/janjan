class Api::GamesController < Api::ApplicationController
  before_action :authenticate_user!

  def show
    game = Game.find(current_user.game&.id)

    render_json game, include: {seats: {user: true, river: :tiles, hand: :tiles}}
  end

  def create
    room = current_user.room

    head :unprocessable_entity unless room.game_startable?(current_user)

    game = Game.new(room: room)

    room.transaction do
      game.save!
      game.scenes.create!(mahjong: Mahjong.create(room.users))
    end

    room.users.each do |user|
      notify(user: user, event: 'room:update', resource: room)
    end

    head :ok
  end
end
