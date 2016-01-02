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

class Action::SelfPick < Action::Base
  def able?
    case last_action
    when Action::Draw
      last_action.seat == seat && WinDetector.new(hand.tiles.map(&:kind)).win?
    else
      false
    end
  end

  def act!(params:)
    # TODO calc
    self.base_point = 2000

    win_point = round.seats.reject {|s| s == seat }.sum do |s|
      if seat.east?
        collect_point!(seat: s, point: ceil(base_point * 2))
      else
        if s.east?
          collect_point!(seat: s, point: ceil(base_point * 2))
        else
          collect_point!(seat: s, point: ceil(base_point))
        end
      end
    end

    seat.update!(point: seat.point + win_point)

    save!
  end

  private

  def ceil(point)
    (point / 100r).ceil * 100
  end

  def collect_point!(point:, seat:)
    seat.update!(point: seat.point - point)

    point
  end
end
