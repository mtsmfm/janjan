module Mahjong
  module Action
    class ConfirmGameEnd < Base
      def act!(*)
        seat.available_actions = []

        seat.user.join.destroy
      end
    end
  end
end
