module NdrBrowserTimings
  # Wraps window.performance.timing objects
  class PerformanceTiming
    include ActiveModel::Model

    # As defined by https://www.w3.org/TR/navigation-timing/#sec-navigation-timing
    TIMING_FIELDS = %w[
      navigationStart unloadEventStart unloadEventEnd redirectStart redirectEnd fetchStart
      domainLookupStart domainLookupEnd connectStart connectEnd secureConnectionStart
      requestStart responseStart responseEnd domLoading domInteractive domContentLoadedEventStart
      domContentLoadedEventEnd domComplete loadEventStart loadEventEnd
    ].freeze

    attr_accessor :controller, :action

    TIMING_FIELDS.each do |field|
      attr_accessor field.underscore
      alias_attribute field, field.underscore if field != field.underscore
    end

    def tags
      { controller: controller, action: action }
    end

    def recordable?
      tags.values.all?(&:present?)
    end

    def timeline
      @timeline ||= {
        unload: diff(unload_event_end, unload_event_start),
        redirect: diff(redirect_end, redirect_start),
        dns: diff(domain_lookup_end, domain_lookup_start),
        connect: diff(connect_end, connect_start),
        request: diff(response_start, request_start),
        response: diff(response_end, response_start),
        dom_loading: diff(dom_loading, response_start),
        dom_interactive: diff(dom_interactive, dom_loading),
        dom_content_loaded_event: diff(dom_content_loaded_event_end, dom_content_loaded_event_start),
        dom_complete: diff(dom_complete, dom_content_loaded_event_end),
        load_event: diff(load_event_end, load_event_start)
      }
    end

    def timing_fields
      TIMING_FIELDS.each_with_object({}) do |key, hash|
        value = send(key)
        next if value.nil?

        hash[key] = value
      end
    end

    private

    # Some browsers will report funky extra values; drop them.
    def sanitize_for_mass_assignment(attributes)
      super.reject { |attr, _val| !respond_to?("#{attr}=") }
    end

    def diff(end_time, start_time)
      return 0 unless start_time && end_time

      (end_time.to_i - start_time.to_i).round
    end
  end
end
