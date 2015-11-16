module ApplicationHelper
  def button_to_action_if_able(type:, user:, room:, params: {})
    if "Action::#{type.to_s.classify}".constantize.able?(user: user, room: room)
      button_to type.to_s.classify, room_actions_path(room, {type: type}.merge(params))
    end
  end
end
