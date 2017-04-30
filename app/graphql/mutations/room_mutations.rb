module RoomMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateRoom'

    return_field :viewer, ViewerType

    resolve -> (obj, inputs, ctx) {
      current_user = ctx[:current_user]

      return GraphQL::ExecutionError.new("User already joined to room") if current_user.room

      Room.transaction do
        room = current_user.room = Room.create!
      end

      {
        viewer: current_user
      }
    }
  end
end
