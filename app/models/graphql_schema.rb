UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :name, types.String
end

module UserMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateUser'
    description 'Create user'

    input_field :name, !types.String
    return_field :viewer, ViewerType

    resolve -> (obj, inputs, ctx) {
      user = User.create!(name: inputs[:name])
      {
        viewer: user
      }
    }
  end
end

MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :CreateUser, field: UserMutations::Create.field
end

ViewerType = GraphQL::ObjectType.define do
  name "Viewer"

  field :id, !types.ID
  field :name, !types.String

  field :users do
    type types[UserType]
    description "Get all User"
    resolve -> (obj, args, ctx) { User.all }
  end
end

QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :viewer, ViewerType do
    resolve -> (_obj, _args, ctx) {
      ctx[:current_user]
    }
  end
end

GraphqlSchema = GraphQL::Schema.define do
  query QueryType
  mutation MutationType
end
