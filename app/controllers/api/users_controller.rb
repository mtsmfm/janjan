class Api::UsersController < Api::ApplicationController
  def show
    render json: current_user
  end
end
