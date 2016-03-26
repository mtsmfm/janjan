class ApplicationCable::Channel < ActionCable::Channel::Base
  private

  def notify(user:, event:, resource:, include: nil)
    EventNotifier.process(
      user:        user,
      event:       event,
      resource:    resource,
      url_options: url_options,
      include:     include
    )
  end

  def notify_all(args)
    User.all.each do |user|
      notify(args.merge(user: user))
    end
  end

  def request
    connection.send(:request)
  end

  def url_options
    options = {
      host:     request.host,
      protocol: request.protocol,
      port:     request.port
    }
    options.merge!(only_path: true) if Rails.env.development?
    options
  end
end
