class Room < ActiveRecord::Base
  has_many :joins
  has_many :users, through: :joins
  has_one :game

  def ready_to_start_game?
    users.count == 4
  end
end
