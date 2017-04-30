class Api::GraphqlController < Api::ApplicationController
  def create
    variables =
      if String === params[:variables]
        JSON.parse(params[:variables])
      else
        params[:variables]
      end

    render json: GraphqlSchema.execute(params[:query], variables: variables, context: {current_user: current_user, controller: self})
  end
end
