class Api::UsersController < Api::ApplicationController
  def show
    user = User.find_by(id: current_user&.id)

    if user
      render_json user
    else
      render json: {user: nil}
    end
  end

  def create
    user = User.create!(user_params)
    login(user)

    render_json user
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
