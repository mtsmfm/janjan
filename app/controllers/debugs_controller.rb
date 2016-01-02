class DebugsController < ApplicationController
  def show
    render layout: false
  end

  def load_fixture
    path = Rails.root.join("test/fixtures/tiles/#{params[:fixture]}")
    yaml = YAML.load_file(path)

    round = Game.last.rounds.last

    round.transaction do
      round.seats.each {|s| s.update!(point: 25000) }
      round.hands.each {|h| h.tiles.destroy_all }
      round.wall.tiles.destroy_all
      round.actions.destroy_all
      round.rivers.each {|r| r.tiles.destroy_all }

      round.seats.each do |seat|
        seat.hand.tiles = yaml[seat.position].map {|kind| Tile.new(kind: kind) }
      end

      round.wall.tiles = yaml['wall'].map {|kind| Tile.new(kind: kind) }
    end

    redirect_to debug_path
  end
end
