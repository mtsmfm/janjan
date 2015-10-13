class Game < ActiveRecord::Base
  has_many :hands, class_name: 'Field::Hand'
  has_one :wall, class_name: 'Field::Wall'
end
