class GameSerializer < ActiveModel::Serializer
  attributes :id, :available_actions

  has_many :seats

  def available_actions
    Action::Base.subclasses.select {|klass|
      klass.new(seat: current_user.seat, round: object.rounds.last).able?
    }.map {|klass| klass.name.demodulize.underscore }
  end
end
