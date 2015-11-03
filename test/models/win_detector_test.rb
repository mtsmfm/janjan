require 'test_helper'

class WinDetectorTest < ActiveSupport::TestCase
  def test_one_ankou
    assert_detection '123456789mEEwRRRd', true
    assert_detection '123456788mEEwRRRd', false
  end

  private

  def assert_detection(tiles, expected)
    tiles = tiles.dup

    m = tiles.slice!(/\d+m/).to_s[0..-2].chars.map {|c| "man_#{c}" }
    p = tiles.slice!(/\d+p/).to_s[0..-2].chars.map {|c| "pin_#{c}" }
    s = tiles.slice!(/\d+s/).to_s[0..-2].chars.map {|c| "sou_#{c}" }
    w = tiles.slice!(/\w+w/).to_s[0..-2].chars.map {|c|
      {
        'E' => 'east',
        'S' => 'south',
        'W' => 'west',
        'N' => 'north',
      }[c]
    }
    d = tiles.slice!(/\w+d/).to_s[0..-2].chars.map {|c|
      {
        'W' => 'haku',
        'G' => 'hatsu',
        'R' => 'chun',
      }[c]
    }

    assert_equal WinDetector.new(m + p + s + w + d).win?, expected
  end
end
