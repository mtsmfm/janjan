class Game < ActiveRecord::Base
  has_many :hands, class_name: 'Field::Hand', dependent: :destroy
  has_one :wall, class_name: 'Field::Wall', dependent: :destroy
end
