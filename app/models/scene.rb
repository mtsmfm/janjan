# == Schema Information
#
# Table name: scenes
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  data       :binary
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_scenes_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_6d63773b7b  (game_id => games.id)
#

class Scene < ApplicationRecord
  attr_writer :mahjong

  before_save -> { self.data = Marshal.dump(mahjong) }

  def mahjong
    @mahjong ||= Marshal.load(data)
  end
end
