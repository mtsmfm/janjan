require 'test_helper'

class HappyPathTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end

  teardown do
    DatabaseRewinder.clean
  end

  test 'happy path' do
    stub_tiles('double_reach')

    allow(Mahjong).to receive(:create).and_wrap_original do |m, users|
      m.call(users).tap do |mahjong|
        mahjong.seats.sort_by(&:position).zip(mahjong.seats.map(&:user).sort_by(&:name)) do |seat, user|
          seat.user = seat.hand.user = seat.river.user = user
        end
      end
    end

    using_sessions *1..4, concurrently: true do
      visit '/'
    end

    using_sessions *1..4 do |i|
      find('input').set("user #{i}")

      click_on 'Login'

      if i == 1
        click_on 'Create Room'
      else
        click_on 'Join'
      end
    end

    using_session 1 do
      click_on 'Start'

      click_on 'Draw'

      within '.user-field .hand[data-discardable=true]' do
        find('.tile[data-tile="pin_1"]', match: :first).click
      end
    end

    using_sessions *2..4 do
      click_on 'Draw'

      within '.user-field .hand[data-discardable=true]' do
        find('.tile', match: :first).click
      end
    end

    using_session 1 do
      click_on 'Draw'

      click_on 'SelfPick'
    end

    using_sessions *1..4 do
      assert_equal 'user 1 self picked!', find('.game-dialog__message').text

      click_on 'OK'
    end

    (1..4).zip((1..4).to_a.rotate) do |dealer, winner|
      stub_tiles('chiho')

      using_session dealer do
        click_on 'Draw'

        within '.user-field .hand[data-discardable=true]' do
          find('.tile', match: :first).click
        end
      end

      using_session winner do
        click_on 'Draw'

        click_on 'SelfPick'
      end

      using_sessions *1..4 do
        assert_equal "user #{winner} self picked!", find('.game-dialog__message').text

        click_on 'OK'
      end
    end

    using_sessions *1..4 do
      assert_equal "user 1 win!", find('.game-dialog__message').text

      click_on 'OK'

      assert page.has_css?(:button, text: 'Create Room')
    end

    # using_sessions *1..4 do
    #   logs = page.driver.browser.manage.logs.get(:browser)
    #   assert logs.all? {|l| l.level != 'SEVERE' }, logs.map(&:message).join("\n")
    # end
  end

  private

  def stub_tiles(fixture_name)
    yaml = YAML.load_file(Rails.root.join("test/fixtures/tiles/#{fixture_name}.yml"))
    allow(Mahjong).to receive(:build_tiles) do
      yaml.values.flatten.map.with_index(1) do |kind, id|
        Mahjong::Tile.new(id: id, kind: kind)
      end
    end
  end
end
