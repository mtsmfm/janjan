class RoomsController < ApplicationController
  before_action -> {
    redirect_to current_user.room if current_user.room
  }, except: :show

  def index
    @rooms = Room.all
  end

  def create
    room = Room.create!

    redirect_to room
  end

  def show
    @room = Room.find(params[:id])

    redirect_to [@room, @room.game] if @room.game
  end
end
