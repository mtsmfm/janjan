class Api::RoomsController < Api::ApplicationController
  before_action :authenticate_user!

  def index
    rooms = Room.joinable

    render_json rooms
  end

  def create
    return head :unprocessable_entity if current_user.room

    room = nil

    Room.transaction do
      room = current_user.room = Room.create!
    end

    notify_all(event: 'room:create', resource: room)

    render_json room
  end

  def show
    room = Room.find(current_user.room&.id)

    render_json room
  end
end
