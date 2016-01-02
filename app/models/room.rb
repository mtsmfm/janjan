# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ActiveRecord::Base
  has_many :joins
  has_many :users, through: :joins
  has_one :game

  def ready_to_start_game?
    users.count == 4
  end
end
