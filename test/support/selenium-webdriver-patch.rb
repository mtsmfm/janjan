module Selenium
  module WebDriver
    module Chrome
      class Service
        def stop
          return if @process.nil? || @process.exited?

          Net::HTTP.start(@host, @port) do |http|
            http.open_timeout = STOP_TIMEOUT / 2
            http.read_timeout = STOP_TIMEOUT / 2

            # XXX HEAD /shutdown return 404
            # It seems to be GET
            # http.head("/shutdown")
            http.get("/shutdown")
          end

          @process.poll_for_exit STOP_TIMEOUT
        rescue ChildProcess::TimeoutError
          @process.stop STOP_TIMEOUT
        end
      end
    end
  end
end
