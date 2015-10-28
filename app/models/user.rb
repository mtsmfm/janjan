class User < ActiveRecord::Base
  has_many :joins
  has_one :hand, class_name: 'Field::Hand'
  has_one :river, class_name: 'Field::River'

  def room
    joins.first.room
  end
end
