class WebNotificationsChannel < ApplicationCable::Channel
  class << self
    def channel_name_for(user)
      "user_#{user.id}"
    end
  end

  def subscribed
    stream_from self.class.channel_name_for(current_user)
  end

  def unsubscribed
    if (room = current_user.room) && !room.game
      current_user.join.destroy!

      room.reload

      notify_all(event: 'room:update',  resource: room)

      if room.users.count.zero?
        room.destroy!
        notify_all(event: 'room:destroy', resource: room)
      end
    end
  end
end
