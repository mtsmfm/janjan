# == Schema Information
#
# Table name: rooms
#
#  id          :integer          not null, primary key
#  joins_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Room < ActiveRecord::Base
  has_many :joins
  has_many :users, through: :joins
  has_one :game, dependent: :destroy

  scope :joinable, -> { Room.where(joins_count: 0..3).joins('LEFT OUTER JOIN games ON games.room_id = rooms.id').where(games: {room_id: nil}) }

  def joinable?(user)
    !(full? || users.exists?(id: user.id) || user.room)
  end

  def game_startable?(user)
    !game && full? && users.exists?(id: user.id)
  end

  def full?
    users.count == 4
  end
end
