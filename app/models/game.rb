# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  room_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_games_on_room_id  (room_id)
#
# Foreign Keys
#
#  fk_rails_b22253b79a  (room_id => rooms.id)
#

class Game < ActiveRecord::Base
  belongs_to :room

  has_many :rounds
  has_many :seats
end
