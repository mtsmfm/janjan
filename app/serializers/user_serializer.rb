class UserSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    "user-#{object.id.first(5)}"
  end
end
