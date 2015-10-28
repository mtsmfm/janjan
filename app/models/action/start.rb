class Action::Start < Action::Base
  class << self
    def able?(user:, room:)
      room.users.count == 4 && !room.game
    end
  end
end
