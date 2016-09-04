class WinDetector
  def initialize(tiles)
    @tiles = tiles
  end

  def win?
    TenpaiWakaruMan.win?(str)
  end

  private

  def str
    @tiles.map do |tile|
      case tile.to_s
      when /(man|pin|sou)_(\d)/
        $2 + $1[0]
      when /(east|south|west|north)/
        $1[0].upcase + 'w'
      when 'haku'
        'Pd'
      when 'hatsu'
        'Fd'
      when 'chun'
        'Cd'
      else
        raise
      end
    end.join
  end
end
