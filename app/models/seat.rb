# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  user_id    :uuid             not null
#  round_id   :integer          not null
#  position   :enum             not null
#  point      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_seats_on_round_id  (round_id)
#  index_seats_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_ad8006b7cb  (round_id => rounds.id)
#  fk_rails_ff1a0875e3  (user_id => users.id)
#

class Seat < ActiveRecord::Base
  pos = %i(east south west north)
  enum position: pos.zip(pos.map(&:to_s)).to_h

  has_one :river, class_name: 'Field::River'
  has_one :hand, class_name: 'Field::Hand'

  belongs_to :round
  belongs_to :user

  def next
    round.seats.find_by!(position: next_position)
  end

  def next_position
    positions = self.class.positions.keys
    positions.zip(positions.rotate).to_h.with_indifferent_access[position]
  end
end
