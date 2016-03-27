module Mahjong
  module Action
    class Draw < Base
      def act!(*)
        hand.tiles << board.wall.tiles.shift

        board.seats.each do |s|
          s.available_actions = []
        end

        seat.available_actions << Discard.new(seat: seat, board: board)
        seat.available_actions << SelfPick.new(seat: seat, board: board) if WinDetector.new(seat.hand.tiles.map(&:kind)).win?
      end
    end
  end
end
