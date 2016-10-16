module EventNotifier
  class << self
    def process(user:, event:, resource:, url_options:, include: nil)
      serializer = ApplicationSerializer.for(resource, current_user: user, url_options: url_options, include: include)

      channel = WebNotificationsChannel.channel_name_for(user)

      ActionCable.server.broadcast channel, {event: event, payload: serializer.as_json}
    end
  end
end
