class ApplicationCable::Connection < ActionCable::Connection::Base
  identified_by :current_user

  def connect
    self.current_user = find_verified_user
  end

  protected

  def find_verified_user
    session = cookies.encrypted[Rails.application.config.session_options[:key]].with_indifferent_access

    if session[:user_id] && User.exists?(session[:user_id])
      User.find(session[:user_id])
    else
      User.create.tap do |user|
        session[:user_id] = user.id
      end
    end
  end
end
