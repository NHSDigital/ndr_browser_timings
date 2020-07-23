# frozen_string_literal: true

module NdrBrowserTimings
  # This helper file is injected into the host application.
  module MetaTagHelper
    # Allow engine mount location to be made available to javascript
    # included by the host application. The alternative would be to
    # server pre-configured JS through the engine directly, rather than
    # as an asset.
    def ndr_browser_timings_meta_tag(sample_rate: 1)
      tag('meta', name: 'ndr_browser_timings_endpoint', content: ndr_browser_timings.receive_path) +
        tag('meta', name: 'ndr_browser_timings_sample_rate', content: sample_rate.to_f)
    end
  end
end
