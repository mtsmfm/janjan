QueryType = GraphQL::ObjectType.define do
  name "Query"
  description "The query root of this schema"

  field :viewer, ViewerType do
    resolve -> (_obj, _args, ctx) {
      ctx[:current_user]
    }
  end
end
