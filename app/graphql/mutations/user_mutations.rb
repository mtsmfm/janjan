module Mutations::UserMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateUser'
    description 'Create user'

    input_field :name, !types.String
    return_field :viewer, Types::ViewerType

    resolve -> (obj, inputs, ctx) {
      user = User.create!(name: inputs[:name])
      ctx[:controller].login(user)

      {
        viewer: user
      }
    }
  end
end
