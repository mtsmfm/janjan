require 'test_helper'

class HappyPathTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver

    ActiveRecord::Base.connection.begin_transaction(joinable: false)
  end

  teardown do
    ActiveRecord::Base.connection.rollback_transaction
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

      click_on 'Create Room'

      visit '/'

      click_on 'Create Join'
    end

    using_session 'user 2' do
      visit '/'

      click_on 'Create Join'
    end

    using_session 'user 3' do
      visit '/'

      click_on 'Create Join'
    end

    using_session 'user 4' do
      visit '/'

      click_on 'Create Join'
    end

    using_session 'user 1' do
      visit '/'

      click_on 'Start'

      click_on 'Draw'
      within first('.hand .tile[data-tile="pin_1"]') do
        click_on 'Discard'
      end
    end

    (2..4).each do |i|
      using_session "user #{i}" do
        click_on 'Draw'

        within first('.hand .tile') do
          click_on 'Discard'
        end
      end
    end

    using_session 'user 1' do
      click_on 'Draw'

      click_on 'SelfPick'
    end
  end
end
