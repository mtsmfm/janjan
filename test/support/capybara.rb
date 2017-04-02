require 'capybara/rails'

# FIXME often we must wait because test server (puma) runs with only one thread
Capybara.default_max_wait_time = 10

# XXX hack to boot browsers concurrently
Capybara.instance_variable_set(:@session_pool, Concurrent::Hash.new)

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

Capybara::Selenium::Driver.prepend(Module.new do
  def quit
    puts find_css('user-info')[0]&.all_text
    puts ?- * 10
    puts browser.manage.logs.get(:browser).select {|l| l.level == 'SEVERE' }.map {|l| l.message.gsub('\n', "\n").gsub('\u003C', "\u003C") }
    puts ?- * 10
    super
  end
end)
