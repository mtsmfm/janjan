# == Schema Information
#
# Table name: tiles
#
#  id         :integer          not null, primary key
#  field_id   :integer          not null
#  kind       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tiles_on_field_id  (field_id)
#
# Foreign Keys
#
#  fk_rails_096a2efd02  (field_id => fields.id)
#

class Tile < ActiveRecord::Base
  # https://en.wikipedia.org/wiki/Japanese_Mahjong#General_mahjong_rules
  KINDS = %i(
    east
    south
    west
    north
    chun
    hatsu
    haku
    man_1
    man_2
    man_3
    man_4
    man_5
    man_6
    man_7
    man_8
    man_9
    sou_1
    sou_2
    sou_3
    sou_4
    sou_5
    sou_6
    sou_7
    sou_8
    sou_9
    pin_1
    pin_2
    pin_3
    pin_4
    pin_5
    pin_6
    pin_7
    pin_8
    pin_9
  )

  belongs_to :round

  class << self
    def build_tiles
      (Tile::KINDS * 4).shuffle.map do |kind|
        Tile.new(kind: kind)
      end
    end
  end
end
