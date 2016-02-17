require 'test_helper'

class WinDetectorTest < ActiveSupport::TestCase
  def test_one_ankou
    assert_predicate     WinDetector.build_from_string('123456789mEEwRRRd'), :win?
    assert_not_predicate WinDetector.build_from_string('123456788mEEwRRRd'), :win?
  end
end
