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
