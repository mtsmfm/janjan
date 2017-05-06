class TestChannel < ApplicationCable::Channel
  def subscribed
    stream_from stream_id
  end

  def unsubscribed
    GraphqlSchema.subscriber.delete(stream_id)
  end

  private

  def stream_id
    params[:id]
  end
end
