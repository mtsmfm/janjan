class Api::JoinsController < Api::ApplicationController
  before_action :authenticate_user!

  def create
    room = Room.find(params[:room_id])

    return head :unprocessable_entity unless room.joinable?(current_user)

    room.with_lock do
      current_user.room = room

      notify_joined(room)
    end

    head :ok
  end

  private

  def notify_joined(room)
    User.all.each do |user|
      notify(user: user, event: 'room:update', resource: room)
    end
  end
end
