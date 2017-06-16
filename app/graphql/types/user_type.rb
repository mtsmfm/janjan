Types::UserType = GraphQL::ObjectType.define do
  name "User"

  global_id_field :id
  field :name, types.String
end
