class Action::Draw < Action::Base
  def able?
    last_action = game.actions.last

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
    seat.hand.tiles << game.wall.tiles.first

    save!
  end
end
