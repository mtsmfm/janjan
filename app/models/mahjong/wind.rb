module Mahjong
  class Wind
    WINDS = %i(east south west north)

    delegate :hash, :to_s, :to_sym, to: :@sym

    class << self
      def all
        WINDS.map {|w| new(w) }
      end
    end

    def initialize(sym)
      @sym = sym
    end

    def next
      self.class.new(WINDS.zip(WINDS.rotate).to_h[@sym])
    end

    def prev
      self.class.new(WINDS.zip(WINDS.rotate(-1)).to_h[@sym])
    end

    def eql?(other)
      hash == other.hash
    end

    def ==(other)
      eql?(other)
    end

    def as_json(*)
      to_s
    end

    def <=>(other)
      WINDS.index(to_sym) <=> WINDS.index(other.to_sym)
    end

    WINDS.each do |w|
      define_method("#{w}?") { @sym == w }
    end
  end
end
