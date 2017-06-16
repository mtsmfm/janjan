class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def login(user)
    session[:user_id] = user.id
  end

  private

  def authenticate_user!
    return head :forbidden unless current_user
  end

  def notify(user:, event:, resource:, include: nil)
    EventNotifier.process(
      user:        user,
      event:       event,
      resource:    resource,
      url_options: url_options,
      include:     include
    )
  end

  def url_options
    Rails.env.development? ? super.merge(only_path: true) : super
  end

  def notify_all(args)
    # XXX
    User.all.each do |user|
      notify(args.merge(user: user))
    end
  end

  def render_json(resource, options = {})
    render json: ApplicationSerializer.for(resource, options.merge(current_user: current_user, url_options: url_options)).as_json
  end

  def current_user
    return @current_user if defined? @current_user

    @current_user = User.find_by(id: session[:user_id])
  end
end
