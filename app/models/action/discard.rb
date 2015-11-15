class Action::Discard < Action::Base
  class << self
    def able?(user:, room:)
      game = room.game

      return false unless game

      last_action = game.actions.last

      case last_action
      when Action::Draw
        last_action.seat == user.seat
      else
        false
      end
    end

    def act!(user:, room:, params:)
      game = room.game

      game.transaction do
        user.river.tiles << user.hand.tiles.find(params[:id])

        Action::Discard.create!(seat: user.seat, game: game)
      end
    end
  end
end
