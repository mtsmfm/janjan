class Mahjong::TileSerializer < ApplicationSerializer
  attributes :id
  attribute :kind,  if: 'object.kind'
  attribute :order, if: 'object.order'
end
