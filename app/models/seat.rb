class Seat < ActiveRecord::Base
  enum position: %i(east south west north)

  has_one :river, class_name: 'Field::River'
  has_one :hand, class_name: 'Field::Hand'

  belongs_to :game
  belongs_to :user

  def next
    game.seats.find_by!(position: next_position)
  end

  def next_position
    positions = self.class.positions.keys
    positions.zip(positions.rotate).to_h.with_indifferent_access[position]
  end
end
