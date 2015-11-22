class ActionsController < ApplicationController
  after_action :notify_action_created

  def create
    action = "Action::#{params[:type].classify}".constantize.new(seat: current_seat, game: current_game)
    raise unless action.able?

    current_game.transaction do
      action.act!(params: params)
    end

    redirect_to [current_game.room, current_game]
  end

  private

  def notify_action_created
    (current_user.room.users - [current_user]).each do |user|
      ActionCable.server.broadcast "web_notifications_#{user.id}", {}
    end
  end

  def current_seat
    @current_seat ||= Seat.find(current_user.seat.id)
  end

  def current_game
    @current_game ||= Game.find(current_user.room.game.id)
  end
end
