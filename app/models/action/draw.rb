class Action::Draw < Action::Base
  class << self
    def able?(user:, room:)
      game = room.game

      return false unless game

      last_action = game.actions.last

      case last_action
      when Action::Start
        last_action.seat == user.seat
      when Action::Discard
        last_action.seat.next == user.seat
      else
        false
      end
    end
  end
end
