class JoinsController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    room.joins.create!(user: current_user)

    redirect_to room
  end
end
