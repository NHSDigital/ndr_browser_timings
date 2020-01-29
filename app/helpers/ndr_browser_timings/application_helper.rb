# frozen_string_literal: true

module NdrBrowserTimings
  # This helper file is injected into the host application.
  module ApplicationHelper
    # Allow engine mount location to be made available to javascript
    # included by the host application. The alternative would be to
    # server pre-configured JS through the engine directly, rather than
    # as an asset.
    def ndr_browser_timings_meta_tag
      tag('meta', name: 'ndr_broser_timings_endpoint', content: ndr_browser_timings.receive_path)
    end
  end
end
