class TileSerializer < ActiveModel::Serializer
  attributes :id, :kind

  def kind
    case object.field
    when ::Field::Hand
      (object.field.seat.user == current_user)? object.kind : nil
    when ::Field::River
      object.kind
    when ::Field::Wall
      nil
    end
  end
end
