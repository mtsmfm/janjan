class Action::Base < ActiveRecord::Base
  self.table_name = 'actions'

  belongs_to :seat
  belongs_to :game
end
