# == Schema Information
#
# Table name: actions
#
#  id         :integer          not null, primary key
#  round_id   :integer          not null
#  type       :string           not null
#  tile_id    :integer
#  seat_id    :integer
#  base_point :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_actions_on_round_id  (round_id)
#
# Foreign Keys
#
#  fk_rails_129ebf637f  (tile_id => tiles.id)
#  fk_rails_1bfa43d13c  (seat_id => seats.id)
#  fk_rails_7427b8435c  (round_id => rounds.id)
#

class Action::Draw < Action::Base
  belongs_to :tile

  def able?
    case last_action
    when nil
      seat.east?
    when Action::Discard
      last_action.seat.next == seat
    else
      false
    end
  end

  def act!(params:)
    new_tile = wall.tiles.first
    hand.tiles << new_tile
    self.tile = new_tile

    save!
  end
end
