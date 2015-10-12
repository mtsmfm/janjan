class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return @current_user if @current_user

    @current_user =
      if session[:user_id]
        User.find(session[:user_id])
      else
        User.create.tap do |user|
          session[:user_id] = user.id
        end
      end
  end
end
