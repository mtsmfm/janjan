class Action::Base < ActiveRecord::Base
  self.table_name = 'actions'

  belongs_to :seat
  belongs_to :round

  with_options through: :seat do
    has_one :river
    has_one :hand
  end

  with_options through: :round do
    has_one :wall
  end

  def last_action
    @last_action ||= round.actions.last
  end
end
