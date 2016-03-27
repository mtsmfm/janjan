class Api::ActionsController < Api::ApplicationController
  before_action :authenticate_user!
  after_action :notify_action_created

  def create
    action = current_seat.available_actions.find {|a| a.type == params[:type] }
    return head :unprocessable_entity unless action

    current_game.transaction do
      action.act!(params: params.permit(*action.permitted_keys))

      current_game.scenes.create!(mahjong: current_mahjong)
    end

    head :ok
  end

  private

  def notify_action_created
    current_game.room.users.each do |user|
      notify(user: user, event: 'game:update', resource: current_game, include: {seats: {user: true, river: :tiles, hand: :tiles}})
    end
  end

  def current_game
    @current_game ||= Game.find(current_user&.room&.game&.id)
  end

  def current_mahjong
    @current_mahjong ||= current_game.scenes.last.mahjong
  end

  def current_seat
    @current_seat ||= current_mahjong.seats.find {|s| s.user == current_user }
  end
end
