begin
  require 'ndr_stats'
rescue LoadError => e
  raise e, <<~MESSAGE
    The NdrStats recorder requires the ndr_stats library to be loaded.
    As an optional codepath it is not an explicit dependency of
    ndr_browser_timings, so you must add it to your Gemfile separately.
  MESSAGE
end

module NdrBrowserTimings
  module Recorders
    # Allows timing information to be recorded via ndr_stats.
    class NdrStats
      def initialize(raise_unless_configured: true)
        raise 'ndr_stats is not configured!' if raise_unless_configured && !::NdrStats.configured?
      end

      def call(timing)
        tags = timing.tags

        timing.timeline.each do |key, duration|
          NdrStats.timing(key, duration, **tags)
        end
      end
    end
  end
end
