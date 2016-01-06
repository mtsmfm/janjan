require 'test_helper'

class HappyPathTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end

  teardown do
    DatabaseRewinder.clean
  end

  test 'happy path' do
    yaml = YAML.load_file(Rails.root.join('test/fixtures/tiles/double_reach.yml'))
    Tile.stubs(:build_tiles).returns(
      yaml.values.flatten.map do |kind|
        Tile.new(kind: kind)
      end
    )

    using_session 'user 1' do
      visit '/'

      click_on 'Create room'

      visit '/'

      click_on 'Create join'
    end

    using_session 'user 2' do
      visit '/'

      click_on 'Create join'
    end

    using_session 'user 3' do
      visit '/'

      click_on 'Create join'
    end

    using_session 'user 4' do
      visit '/'

      click_on 'Create join'
    end

    using_session 'user 1' do
      visit '/'

      click_on 'Start'

      click_on 'Draw'

      first('.hand .tile[data-tile="pin_1"]').click

      click_on 'Discard'
    end

    (2..4).each do |i|
      using_session "user #{i}" do
        click_on 'Draw'

        first('.hand .tile').click

        click_on 'Discard'
      end
    end

    using_session 'user 1' do
      click_on 'Draw'

      click_on 'SelfPick'
    end
  end
end
