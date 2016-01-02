# == Schema Information
#
# Table name: fields
#
#  id         :integer          not null, primary key
#  round_id   :integer          not null
#  seat_id    :integer
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_fields_on_round_id  (round_id)
#  index_fields_on_seat_id   (seat_id)
#
# Foreign Keys
#
#  fk_rails_5a07ad9e8e  (seat_id => seats.id)
#  fk_rails_e3a41da4fd  (round_id => rounds.id)
#

class Field::River < Field::Base
  belongs_to :seat
end
