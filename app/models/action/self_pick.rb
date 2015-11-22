class Action::SelfPick < Action::Base
  def able?
    last_action = game.actions.last

    case last_action
    when Action::Draw
      last_action.seat == seat && WinDetector.new(seat.hand.tiles.map(&:kind)).win?
    else
      false
    end
  end

  def act!(params:)
    save!
  end
end
