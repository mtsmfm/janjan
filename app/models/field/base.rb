class Field::Base < ActiveRecord::Base
  self.table_name = 'fields'

  belongs_to :game
  has_many :tiles, foreign_key: :field_id, dependent: :destroy
end
