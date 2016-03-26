module Mahjong
  module Action
    class Base
      include ActiveModel::Model
      attr_accessor :seat, :board, :meta

      def permitted_keys
        []
      end

      def type
        self.class.name.demodulize.underscore
      end

      private

      def next_seat
        @next_seat ||= board.seats.find {|s| s.position == seat.position.next }
      end

      def river
        @river ||= seat.river
      end

      def hand
        @hand ||= seat.hand
      end
    end
  end
end
