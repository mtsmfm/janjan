class DebugsController < ApplicationController
  def show
    render layout: false
  end

  def load_fixture
    path = Rails.root.join("test/fixtures/tiles/#{params[:fixture]}")
    yaml = YAML.load_file(path)

    game = Game.last

    game.transaction do
      game.seats.each {|s| s.update!(point: 25000) }
      game.hands.each {|h| h.tiles.destroy_all }
      game.wall.tiles.destroy_all
      game.actions.destroy_all

      game.seats.each do |seat|
        seat.hand.tiles = yaml[seat.position].map {|kind| Tile.new(kind: kind) }
      end

      game.wall.tiles = yaml['wall'].map {|kind| Tile.new(kind: kind) }
    end

    redirect_to debug_path
  end
end
