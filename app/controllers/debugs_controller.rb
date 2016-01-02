class DebugsController < ApplicationController
  def show
    render layout: false
  end

  def load_fixture
    path = Rails.root.join("test/fixtures/tiles/#{params[:fixture]}")
    yaml = YAML.load_file(path)

    game = Game.last
    round = game.rounds.last

    game.transaction do
      round.hands.each {|h| h.tiles.destroy_all }
      round.wall.tiles.destroy_all
      round.actions.destroy_all
      round.rivers.each {|r| r.tiles.destroy_all }

      game.seats.each do |seat|
        seat.update!(point: 25000)
        seat.hand.tiles = yaml[seat.position].map {|kind| Tile.new(kind: kind) }
      end

      round.wall.tiles = yaml['wall'].map {|kind| Tile.new(kind: kind) }
    end

    redirect_to debug_path
  end
end
