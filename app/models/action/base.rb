class Action::Base < ActiveRecord::Base
  self.table_name = 'actions'

  belongs_to :user
  belongs_to :game
end
