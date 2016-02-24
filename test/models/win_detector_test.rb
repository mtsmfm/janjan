require 'test_helper'

class WinDetectorTest < ActiveSupport::TestCase
  def test_one_ankou
    assert { WinDetector.build_from_string('123456789mEEwRRRd').win? == true }
    assert { WinDetector.build_from_string('123456788mEEwRRRd').win? == false }
  end
end
