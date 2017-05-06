class Api::GraphqlController < Api::ApplicationController
  def create
    variables =
      if String === params[:variables]
        JSON.parse(params[:variables])
      else
        params[:variables]
      end

    context = {current_user: current_user, controller: self}
    context[:channel] = SecureRandom.uuid if GraphQL::Query.new(GraphqlSchema, params[:query]).subscription?

    render json: GraphqlSchema.execute(params[:query], variables: variables, context: context)
  end
end
