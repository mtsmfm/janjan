class Round < ActiveRecord::Base
  has_many :hands, class_name: 'Field::Hand', dependent: :destroy
  has_many :rivers, class_name: 'Field::River', dependent: :destroy
  has_one :wall, class_name: 'Field::Wall', dependent: :destroy
  has_many :actions, class_name: 'Action::Base', dependent: :destroy
  has_many :users, through: :seats
  has_many :seats

  belongs_to :game

  def end?
    actions.last.instance_of?(Action::SelfPick)
  end
end
