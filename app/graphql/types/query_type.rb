Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :viewer, Types::ViewerType do
    resolve -> (_obj, _args, ctx) {
      ctx[:current_user]
    }
  end
end
