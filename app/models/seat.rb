# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  user_id    :uuid             not null
#  game_id    :integer          not null
#  position   :enum             not null
#  point      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_seats_on_game_id  (game_id)
#  index_seats_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_fa444e0ac6  (game_id => games.id)
#  fk_rails_ff1a0875e3  (user_id => users.id)
#

class Seat < ActiveRecord::Base
  enum position: Wind::WINDS_ENUM_HASH

  has_one :river, class_name: 'Field::River'
  has_one :hand, class_name: 'Field::Hand'

  belongs_to :game
  belongs_to :user

  def next
    game.seats.find_by!(position: next_position)
  end

  def next_position
    Wind.new(position).next
  end
end
