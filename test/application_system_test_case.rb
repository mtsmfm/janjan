require "test_helper"
require "socket"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [500, 300], options: {url: "http://chrome:4444/wd/hub"}

  def setup
    host! "http://#{Socket.gethostname}"

    super
  end
end
