Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :CreateUser, field: Mutations::UserMutations::Create.field
  field :CreateRoom, field: Mutations::RoomMutations::Create.field
  field :JoinRoom, field: Mutations::RoomMutations::Join.field
end
