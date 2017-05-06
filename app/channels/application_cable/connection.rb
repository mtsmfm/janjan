class ApplicationCable::Connection < ActionCable::Connection::Base
  identified_by :current_user

  def connect
    self.current_user = find_verified_user
  end

  protected

  def find_verified_user
    session = cookies.encrypted[Rails.application.config.session_options[:key]].with_indifferent_access

    User.find_by(id: session[:user_id]) || reject_unauthorized_connection
  end
end
