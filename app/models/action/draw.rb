class Action::Draw < Action::Base
  class << self
    def able?(user:, room:)
      game = room.game

      return false unless game

      last_action = game.actions.last

      case last_action
      when Action::Start
        last_action.user == user
      when Action::Discard
        game.next_user(last_action.user)
      else
        false
      end
    end
  end
end
