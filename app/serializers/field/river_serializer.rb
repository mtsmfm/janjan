class Field::RiverSerializer < ActiveModel::Serializer
  attributes :id

  has_many :tiles
end
