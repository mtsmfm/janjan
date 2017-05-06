module MessageTypes
  SUBSCRIPTION_FAIL = 'subscription_fail'
  SUBSCRIPTION_END = 'subscription_end'
  SUBSCRIPTION_DATA = 'subscription_data'
  SUBSCRIPTION_START = 'subscription_start'
  SUBSCRIPTION_SUCCESS = 'subscription_success'
  KEEPALIVE = 'keepalive'
  INIT = 'init'
  INIT_SUCCESS = 'init_success'
  INIT_FAIL = 'init_fail'
end

GRAPHQL_SUBSCRIPTIONS = 'graphql-subscriptions'

module SubscriptionsHack
  def execute_command(data)
    case data["type"]
    when MessageTypes::INIT
      connection.transmit type: MessageTypes::INIT_SUCCESS
      # TODO INIT_FAIL
    when MessageTypes::SUBSCRIPTION_START
      add data
      connection.transmit type: MessageTypes::SUBSCRIPTION_SUCCESS, id: data["id"]
      # TODO SUBSCRIPTION_FAIL
    when MessageTypes::SUBSCRIPTION_END
      remove data
    when MessageTypes::SUBSCRIPTION_DATA
      connection.transmit type: MessageTypes::SUBSCRIPTION_SUCCESS, id: data["id"]
    end
  end

  def add(data)
    data["identifier"] = data["id"]
    super
  end

  def remove(data)
    data["identifier"] = data["id"]
    super
  end
end

class ApplicationCable::Connection < ActionCable::Connection::Base
  # include(Module.new do
  #   # Copy from ActionCable
  #   def initialize(server, env, coder: ActiveSupport::JSON)
  #     @server, @env, @coder = server, env, coder
  #
  #     @worker_pool = server.worker_pool
  #     @logger = new_tagged_logger
  #
  #     @websocket      = ActionCable::Connection::WebSocket.new(env, self, event_loop, protocols: [GRAPHQL_SUBSCRIPTIONS])
  #     @subscriptions  = ActionCable::Connection::Subscriptions.new(self)
  #     @subscriptions.extend(SubscriptionsHack)
  #     @message_buffer = ActionCable::Connection::MessageBuffer.new(self)
  #
  #     @_internal_subscriptions = nil
  #     @started_at = Time.now
  #   end
  #
  #   def beat
  #     transmit type: MessageTypes::KEEPALIVE
  #   end
  #
  #   def send_welcome_message; end
  # end)

  identified_by :current_user

  def connect
    self.current_user = find_verified_user
  end

  protected

  def find_verified_user
    session = cookies.encrypted[Rails.application.config.session_options[:key]].with_indifferent_access

    User.find_by(id: session[:user_id]) || reject_unauthorized_connection
  end
end
