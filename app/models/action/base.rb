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

class Action::Base < ActiveRecord::Base
  self.table_name = 'actions'

  belongs_to :seat
  belongs_to :round

  with_options through: :seat do
    has_one :river
    has_one :hand
  end

  with_options through: :round do
    has_one :wall
  end

  def last_action
    @last_action ||= round.actions.last
  end
end

%w(
discard draw self_pick
).each {|a| require_dependency "action/#{a}" }
