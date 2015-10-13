class User < ActiveRecord::Base
  has_many :joins
  has_one :hand, class_name: 'Field::Hand'

  def room
    joins.first.room
  end
end
