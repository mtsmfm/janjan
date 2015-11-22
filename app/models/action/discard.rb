class Action::Discard < Action::Base
  def able?
    last_action = game.actions.last

    case last_action
    when Action::Draw
      last_action.seat == seat
    else
      false
    end
  end

  def act!(params:)
    seat.river.tiles << seat.hand.tiles.find(params[:id])

    save!
  end
end
