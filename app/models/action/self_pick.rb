class Action::SelfPick < Action::Base
  def able?
    case last_action
    when Action::Draw
      last_action.seat == seat && WinDetector.new(hand.tiles.map(&:kind)).win?
    else
      false
    end
  end

  def act!(params:)
    save!
  end
end
