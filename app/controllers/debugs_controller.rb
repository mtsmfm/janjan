class DebugsController < ApplicationController
  def show
    render layout: false
  end

  def load_fixture
    path = Rails.root.join("test/fixtures/tiles/#{params[:fixture]}")
    yaml = YAML.load_file(path)

    game = Game.last

    game.transaction do
      mahjong = game.scenes.last.mahjong

      id = 0
      mahjong.seats.each do |seat|
        seat.hand.tiles = yaml[seat.position].map {|kind| Mahjong::Tile.new(id: id += 1, kind: kind) }
        seat.river.tiles = []
        seat.available_actions = []
        seat.available_actions << Mahjong::Action::Draw.new(seat: seat, board: mahjong) if seat.east?
      end

      mahjong.wall.tiles = yaml[:wall].map {|kind| Mahjong::Tile.new(id: id += 1, kind: kind) }

      game.scenes.create!(mahjong: mahjong)
    end

    redirect_to debug_path
  end
end
