# == Schema Information
#
# Table name: users
#
#  id         :uuid             not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_one :join
  has_one :hand, class_name: 'Field::Hand', through: :seat
  has_one :river, class_name: 'Field::River', through: :seat
  has_one :room, through: :join
  has_one :game, through: :room
  has_one :seat
end
