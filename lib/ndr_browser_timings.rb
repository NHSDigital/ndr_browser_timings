# frozen_string_literal: true

require 'ndr_browser_timings/engine'

# NdrBrowserTimings is a Rails engine that allows clients' browsers
# timing information to be sent back to the application and captured.
module NdrBrowserTimings
  class << self
    attr_accessor :recorders

    def record(timing)
      return unless timing.recordable?

      recorders.each { |recorder| recorder.call(timing) }
    end
  end

  self.recorders = []
end
