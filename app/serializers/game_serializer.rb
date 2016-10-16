class GameSerializer < ApplicationSerializer
  attributes :id, :links, :round_number, :bonus_count, :wind

  has_many :seats

  delegate :round_number, :bonus_count, :seats, :wind, to: :mahjong

  def links
    available_actions.map {|action|
      [
        action.type,
        {
          url:  url_helpers.api_game_action_path(type: action.type),
          meta: action.meta
        }
      ]
    }.to_h
  end

  private

  def mahjong
    @mahjong ||= object.scenes.last.mahjong
  end

  def current_seat
    @current_seat ||= mahjong.seats.find {|s| s.user == current_user }
  end

  def available_actions
    @available_actions ||= current_seat.available_actions
  end
end
