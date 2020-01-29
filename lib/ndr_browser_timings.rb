# frozen_string_literal: true

require 'ndr_browser_timings/engine'

# NdrBrowserTimings is a Rails engine that allows clients' browsers
# timing information to be sent back to the application and captured.
module NdrBrowserTimings
  # Callable object (called with controller context) that is used to check
  # if the current user is authenticated with the host app.
  mattr_accessor :check_current_user_authentication
  self.check_current_user_authentication = nil # Must be configured by the host app

  # Recorders are callable objects that receiving timings
  mattr_accessor :recorders
  self.recorders = []

  class << self
    def record(timing)
      return unless timing.recordable?

      recorders.each { |recorder| recorder.call(timing) }
    end
  end
end
