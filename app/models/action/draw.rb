class Action::Draw < Action::Base
  class << self
    def able?(user:, room:)
      game = room.game

      return false unless game

      last_action = game.actions.last

      case last_action
      when nil
        user.seat.east?
      when Action::Discard
        last_action.seat.next == user.seat
      else
        false
      end
    end

    def act!(user:, room:, params:)
      game = room.game

      game.transaction do
        user.hand.tiles << game.wall.tiles.first

        Action::Draw.create!(seat: user.seat, game: game)
      end
    end
  end
end
