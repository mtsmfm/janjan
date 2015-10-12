class RoomsController < ApplicationController
  before_action -> {
    if current_user.joins.exists?
      redirect_to current_user.joins.first.room
    end
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
  end
end
