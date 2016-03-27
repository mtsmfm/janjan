module Mahjong
  module Action
    class ConfirmRoundEnd < Base
      def act!(*)
        seat.available_actions = []

        return if exist_not_confirmed_player?

        if !win_east? && last_round?
          end_game
        else
          if win_east?
            succ_bonus
          else
            succ_round
          end
          start_next_hand
        end
      end

      private

      def succ_bonus
        board.bonus_count += 1
      end

      def succ_round
        board.round_number += 1
        board.bonus_count = 0
        board.seats.each do |seat|
          seat.position = seat.position.prev
        end
      end

      def start_next_hand
        Mahjong.deal(board)
      end

      def exist_not_confirmed_player?
        board.seats.any? {|s| s.available_actions.any? }
      end

      def win_east?
        meta[:position].east?
      end

      def last_round?
        board.east? && board.round_number == 4
      end

      def end_game
        seats = board.seats.sort_by {|s| s.position.prev }.sort_by.with_index {|s, i| [-s.point, i] }
        winner = seats.first.user
        results = seats.map {|s| {user: s.user, point: s.point} }
        message = "#{winner.name} win!"

        board.seats.each {|s|
          s.available_actions = [Mahjong::Action::ConfirmGameEnd.new(seat: s, board: board, meta: {
            message:  message,
            winner:   winner,
            results:  results
          })]
        }
      end
    end
  end
end
