class Action::Draw < Action::Base
  def able?
    case last_action
    when nil
      seat.east?
    when Action::Discard
      last_action.seat.next == seat
    else
      false
    end
  end

  def act!(params:)
    hand.tiles << wall.tiles.first

    save!
  end
end
