class Api::GamesController < Api::ApplicationController
  def show
    game = Game.find(current_user.game&.id)

    render json: game, include: {seats: {user: true, river: :tiles, hand: :tiles}}
  end
end
