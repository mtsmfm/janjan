class ApplicationSerializer < ActiveModel::Serializer
  class << self
    def for(resource, current_user:, url_options:, include: nil)
      serializable_resource = ActiveModelSerializers::SerializableResource.new(
        resource, scope: current_user, scope_name: :current_user, url_options: url_options, include: include
      )
      serializable_resource.adapter
      serializable_resource
    end
  end

  class UrlHelpers
    attr_reader :url_options

    def initialize(url_options)
      @url_options = url_options
    end

    private

    def method_missing(method, *args)
      options = args.extract_options! || {}
      options.merge!(url_options)

      if helpers.respond_to?(method)
        helpers.public_send(method, *args, options)
      else
        super
      end
    end

    def helpers
      @helpers ||= Rails.application.routes.url_helpers
    end
  end

  def url_helpers
    @url_helpers ||= UrlHelpers.new(@instance_options[:url_options])
  end
end
