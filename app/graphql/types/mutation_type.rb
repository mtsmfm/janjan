MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :CreateUser, field: UserMutations::Create.field
  field :CreateRoom, field: RoomMutations::Create.field
end
