class User < ActiveRecord::Base
  has_one :join
  has_one :hand, class_name: 'Field::Hand'
  has_one :river, class_name: 'Field::River'
  has_one :room, through: :join
end
