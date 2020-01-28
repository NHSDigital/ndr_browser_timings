module NdrBrowserTimings
  module Recorders
    # Allows timing information to be recorded via the application log.
    class Logger
      def call(timing)
        Rails.logger.info "NdrBrowserTimings #{timing.tags} #{timing.timeline}"
      end
    end
  end
end
