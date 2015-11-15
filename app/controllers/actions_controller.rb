class ActionsController < ApplicationController
  after_action :notify_action_created

  def create
    klass = "Action::#{params[:type].classify}".constantize
    raise unless klass.able?(user: current_user, room: current_room)

    klass.act!(user: current_user, room: current_room, params: params)

    redirect_to current_room
  end

  private

  def notify_action_created
    (current_user.room.users - [current_user]).each do |user|
      ActionCable.server.broadcast "web_notifications_#{user.id}", {}
    end
  end

  def current_room
    @current_room ||= Room.find(current_user.room.id)
  end
end
