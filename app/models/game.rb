class Game < ActiveRecord::Base
  has_many :hands, class_name: 'Field::Hand', dependent: :destroy
  has_many :rivers, class_name: 'Field::River', dependent: :destroy
  has_one :wall, class_name: 'Field::Wall', dependent: :destroy
  has_many :actions, class_name: 'Action::Base', dependent: :destroy
  has_many :users, through: :room

  belongs_to :room

  def next_user(user)
    index = {
      0 => 1,
      1 => 2,
      2 => 3,
      3 => 0,
    }[users.index(user)]

    users[index]
  end
end
