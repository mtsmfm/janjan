class Api::GraphqlController < Api::ApplicationController
  def create
    variables =
      if String === params[:variables]
        JSON.parse(params[:variables])
      else
        params[:variables]
      end

    context = {current_user: current_user, controller: self}
    if GraphQL::Query.new(GraphqlSchema, params[:query]).subscription?
      headers["x-graphql-subscription-id"] = context[:channel] = GraphqlSubscriptionDatabase::Stream.create!.id
    end

    render json: GraphqlSchema.execute(params[:query], variables: variables, context: context)
  end
end
