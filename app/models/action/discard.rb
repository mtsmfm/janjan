class Action::Discard < Action::Base
  def able?
    case last_action
    when Action::Draw
      last_action.seat == seat
    else
      false
    end
  end

  def act!(params:)
    river.tiles << hand.tiles.find(params[:id])

    save!
  end
end
