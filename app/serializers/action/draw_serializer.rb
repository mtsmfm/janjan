class Action::DrawSerializer < Action::BaseSerializer
  attributes :id

  belongs_to :tile
end
