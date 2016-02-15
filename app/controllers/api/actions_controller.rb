class Api::ActionsController < Api::ApplicationController
  after_action :notify_action_created

  def create
    action = "Action::#{params[:type].classify}".constantize.new(seat: current_seat, round: current_round)
    raise unless action.able?

    current_round.transaction do
      action.act!(params: params)
    end

    render json: Game.find(current_game.id), include: {seats: {user: true, river: :tiles, hand: :tiles}}
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

  def current_round
    @current_round ||= current_game.rounds.last
  end
end
