class SeatSerializer < ActiveModel::Serializer
  attributes :id, :position, :point

  belongs_to :user
  has_one :river
  has_one :hand
end
