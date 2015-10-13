class Room < ActiveRecord::Base
  has_many :joins
  has_many :users, through: :joins
  has_one :game
end
