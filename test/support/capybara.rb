require 'capybara/rails'

ActionDispatch::IntegrationTest.include(Capybara::DSL)

Capybara.server = :puma

Capybara.default_driver = Capybara.javascript_driver = if ENV['CI']
  :browserstack
else
  :chrome
end

Capybara.default_max_wait_time = 30 if ENV['CI']

# XXX hack to boot browsers concurrently
Capybara.instance_variable_set(:@session_pool, Concurrent::Hash.new)
Capybara::Server.new(Capybara.app).boot

module CapybaraConcurrentSupport
  def using_sessions(*session_names, concurrently: false, &block)
    threads = session_names.map {|session_name|
      Thread.new(session_name) {|n|
        using_session n do
          block.call n
        end
      }.tap do |t|
        t.join unless concurrently
      end
    }

    threads.each(&:join) if concurrently
  end
end

ActionDispatch::IntegrationTest.include(CapybaraConcurrentSupport)

module CapybaraWithDelay
  Capybara::Session::DSL_METHODS.each do |method|
    eval <<~RUBY
      def #{method}(*)
        super.tap do
          sleep ENV['CAPYBARA_DELAY'].to_f
        end
      end
    RUBY
  end
end

ActionDispatch::IntegrationTest.prepend(CapybaraWithDelay) if ENV['CAPYBARA_DELAY']
