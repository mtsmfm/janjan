module Mutations::RoomMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateRoom'

    return_field :viewer, Types::ViewerType

    resolve -> (obj, inputs, ctx) {
      current_user = ctx[:current_user]

      return GraphQL::ExecutionError.new("User already joined to room") if current_user.room

      room = nil

      Room.transaction do
        room = current_user.room = Room.create!
      end

      GraphqlSchema.subscriber.trigger("roomSubscribe", inputs, OpenStruct.new(node: room, mutation: :CREATED))

      {
        viewer: current_user
      }
    }
  end

  Join = GraphQL::Relay::Mutation.define do
    name 'JoinRoom'

    input_field :id, !types.ID
    return_field :viewer, Types::ViewerType

    resolve -> (obj, inputs, ctx) {
      current_user = ctx[:current_user]

      room = GraphqlSchema.object_from_id(inputs[:id], ctx)

      return GraphQL::ExecutionError.new("Can't join") unless room.joinable?(current_user)

      room.with_lock do
        current_user.room = room
      end

      GraphqlSchema.subscriber.trigger("roomSubscribe", inputs, OpenStruct.new(node: room, mutation: :UPDATED))

      {
        viewer: current_user
      }
    }
  end
end
