module EventNotifier
  class << self
    def process(user:, event:, resource:, url_options:, include: nil)
      serializer = ApplicationSerializer.for(resource, current_user: user, url_options: url_options, include: include)

      channel = WebNotificationsChannel.channel_name_for(user)

      ActionCable.server.broadcast channel, serializer.as_json.merge(event: event)
    end
  end
end
