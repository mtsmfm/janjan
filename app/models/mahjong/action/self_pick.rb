module Mahjong
  module Action
    class SelfPick < Base
      def act!(*)
        # TODO calc
        base_point = 2000

        win_point = board.seats.reject {|s| s.position == seat.position }.sum do |s|
          if seat.east?
            ceil(base_point * 2)
          else
            if s.east?
              ceil(base_point * 2)
            else
              ceil(base_point)
            end
          end.tap do |point|
            s.point -= point
          end
        end

        seat.point += win_point

        board.seats.each do |s|
          s.available_actions = [
            ConfirmRoundEnd.new(seat: s, board: board, meta: {
              message:    message,
              position:   seat.position,
              tiles:      seat.hand.tiles,
              base_point: base_point
            })
          ]
        end
      end

      private

      def message
        <<~EOS
          #{seat.user.name} self picked!
        EOS
      end

      def ceil(point)
        (point / 100r).ceil * 100
      end
    end
  end
end
