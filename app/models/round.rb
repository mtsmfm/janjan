# == Schema Information
#
# Table name: rounds
#
#  id         :integer          not null, primary key
#  game_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rounds_on_game_id  (game_id)
#
# Foreign Keys
#
#  fk_rails_7812c1b477  (game_id => games.id)
#

class Round < ActiveRecord::Base
  has_many :hands, class_name: 'Field::Hand', dependent: :destroy
  has_many :rivers, class_name: 'Field::River', dependent: :destroy
  has_one :wall, class_name: 'Field::Wall', dependent: :destroy
  has_many :actions, class_name: 'Action::Base', dependent: :destroy
  has_many :users, through: :seats

  belongs_to :game

  def end?
    actions.last.instance_of?(Action::SelfPick)
  end
end
