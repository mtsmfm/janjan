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
    # TODO calc
    self.base_point = 2000

    win_point = round.seats.reject {|s| s == seat }.sum do |s|
      if seat.east?
        collect_point!(seat: s, point: ceil(base_point * 2))
      else
        if s.east?
          collect_point!(seat: s, point: ceil(base_point * 2))
        else
          collect_point!(seat: s, point: ceil(base_point))
        end
      end
    end

    seat.update!(point: seat.point + win_point)

    save!
  end

  private

  def ceil(point)
    (point / 100r).ceil * 100
  end

  def collect_point!(point:, seat:)
    seat.update!(point: seat.point - point)

    point
  end
end
