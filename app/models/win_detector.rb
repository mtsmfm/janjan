class WinDetector
  class Tile
    class << self
      def for(str)
        str = str.to_s

        case str
        when /man_(\d)/
          Man.new(number: $1.to_i)
        when /pin_(\d)/
          Pin.new(number: $1.to_i)
        when /sou_(\d)/
          Sou.new(number: $1.to_i)
        when *%w(east south west north haku hatsu chun)
          "WinDetector::#{str.classify}".constantize.new
        else
          raise ArgumentError
        end
      end
    end

    def hash
      inspect.hash
    end

    def <=>(other)
      self.order <=> other.order
    end
  end

  class Honor < Tile
    def eql?(other)
      self == other
    end

    def ==(other)
      self.class == other.class
    end

    def inspect
      self.class.name
    end
  end

  class Wind < Honor; end

  class East  < Wind; def order; 1 end end
  class South < Wind; def order; 2 end end
  class West  < Wind; def order; 3 end end
  class North < Wind; def order; 4 end end

  class Dragon < Honor; end

  class Haku  < Dragon; def order; 5 end end
  class Hatsu < Dragon; def order; 6 end end
  class Chun  < Dragon; def order; 7 end end

  class Suited < Tile
    attr_reader :number

    def initialize(number:)
      @number = number
    end

    def next
      nil if number == 9

      self.class.new(number: @number.next)
    end

    def eql?(other)
      self == other
    end

    def ==(other)
      self.class == other.class && number == other.number
    end

    def inspect
      "#{self.class.name.demodulize[0]}:#{number}"
    end
  end

  class Pin < Suited; def order; number + 10 end end
  class Sou < Suited; def order; number + 20 end end
  class Man < Suited; def order; number + 30 end end

  class Hand
    attr_accessor :head, :tiles, :sequences, :triplets

    def initialize(head:, tiles:, sequences: [], triplets: [])
      @head      = head
      @sequences = sequences
      @triplets  = triplets
      @tiles     = tiles
    end

    def triplet?(tile)
      @tiles.count(tile) >= 3
    end

    def sequence?(tile)
      case tile
      when Suited
        tile.next && tile.next.next && @tiles.include?(tile.next) && @tiles.include?(tile.next.next)
      else
        false
      end
    end

    def extract_triplet(tile)
      @triplets << @tiles.slice!(@tiles.index(tile), 3)

      self
    end

    def extract_sequence(tile)
      sequence = [
        tile,
        tile.next,
        tile.next.next
      ]

      sequence.each do |t|
        @tiles.delete_at(@tiles.index(t))
      end

      @sequences << sequence

      self
    end

    def dup
      self.class.new(
        head: head.dup, tiles: tiles.dup, sequences: sequences.dup, triplets: triplets.dup
      )
    end

  end

  def initialize(tiles)
    @tiles = tiles.map {|tile| Tile.for(tile) }.sort
  end

  def win?
    hands = heads.map do |head|
      Hand.new(head: head, tiles: tiles_except_head(head))
    end

    hands.each.with_object([]) do |hand, combinations|
      combinations.push(*detect(hand))
    end.any?
  end

  private

  def heads
    @tiles.uniq.select {|t| @tiles.count(t) >= 2 }
  end

  def tiles_except_head(head)
    tiles = @tiles.dup

    tiles.slice!(@tiles.index(head), 2)
    tiles
  end

  def detect(hand)
    return [hand] if hand.tiles.empty?

    hand.tiles.uniq.each.with_object([]) do |tile, hands|
      if hand.triplet?(tile)
        hands.push(*detect(hand.dup.extract_triplet(tile)))
      end

      if hand.sequence?(tile)
        hands.push(*detect(hand.dup.extract_sequence(tile)))
      end
    end
  end
end
