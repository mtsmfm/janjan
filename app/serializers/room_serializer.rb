class RoomSerializer < ApplicationSerializer
  attributes :id, :links

  has_one :game
  has_many :users

  def links
    val = {}
    val.merge!(join:  {url: url_helpers.api_room_joins_url(object)}) if object.joinable?(current_user)
    val.merge!(start: {url: url_helpers.api_game_url})                if object.game_startable?(current_user)
    val
  end
end
