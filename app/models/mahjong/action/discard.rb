module Mahjong
  module Action
    class Discard < Base
      def permitted_keys
        %i(id)
      end

      def act!(params:)
        river.tiles << hand.tiles.slice!(hand.tiles.find_index {|t| t.id == params[:id].to_i })

        board.seats.each do |s|
          s.available_actions = []
        end

        next_seat.available_actions << Draw.new(seat: next_seat, board: board)
      end
    end
  end
end
