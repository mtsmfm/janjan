module GraphqlSubscriptionStreamTransport
  class << self
    # Part of the subscription API: send `result` over `channel`.
    def deliver(channel, result, ctx)
      GraphqlChannel.broadcast_to(channel, result)
    end
  end
end
