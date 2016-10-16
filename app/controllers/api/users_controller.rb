class Api::UsersController < Api::ApplicationController
  def show
    return head :not_found unless current_user

    user = User.find_by!(id: current_user.id)
    render_json user
  end

  def create
    user = User.create!(user_params)
    login(user)

    render_json user
  end

  private

  def user_params
    params.permit(:name)
  end
end
