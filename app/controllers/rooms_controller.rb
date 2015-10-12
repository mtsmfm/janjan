class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def create
    room = Room.create!

    redirect_to room
  end

  def show
    @room = Room.find(params[:id])
  end
end
