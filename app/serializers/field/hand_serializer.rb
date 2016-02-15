class Field::HandSerializer < ActiveModel::Serializer
  attributes :id

  has_many :tiles
end
