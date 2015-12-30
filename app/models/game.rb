class Game < ActiveRecord::Base
  belongs_to :room

  has_many :rounds
end
