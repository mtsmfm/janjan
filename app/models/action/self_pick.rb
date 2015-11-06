class Action::SelfPick < Action::Base
  class << self
    def able?(user:, room:)
      game = room.game

      return false unless game

      last_action = game.actions.last

      case last_action
      when Action::Draw
        last_action.user == user && WinDetector.new(user.hand.tiles.map(&:kind)).win?
      else
        false
      end
    end
  end
end
