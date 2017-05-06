MutationEnumType = GraphQL::EnumType.define do
  name "MutationEnum"

  value :CREATED
  value :UPDATED
  value :DELETED
end
