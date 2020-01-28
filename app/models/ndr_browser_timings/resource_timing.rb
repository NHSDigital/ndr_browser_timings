module NdrBrowserTimings
  # Wraps window.performance.getEntry() objects
  class ResourceTiming < PerformanceTiming
    include ActiveModel::Model

    # As defined by https://www.w3.org/TR/resource-timing-2/#sec-performanceresourcetiming
    RESOURCE_FIELDS = %w[
      initiatorType nextHopProtocol workerStart transferSize encodedBodySize decodedBodySize
      startTime entryType duration
    ].freeze

    RESOURCE_FIELDS.each do |field|
      attr_accessor field.underscore
      alias_attribute field, field.underscore if field != field.underscore
    end

    # def tags
    #   { controller: controller, action: action }
    # end

    # def recordable?
    #   tags.values.all?(&:present?)
    # end

    # def timeline
    #   @timeline ||= {
    #     unload: unload_event_end - unload_event_start,
    #     redirect: redirect_end - redirect_start,
    #     dns: domain_lookup_end - domain_lookup_start,
    #     connect: connect_end - connect_start,
    #     request: response_start - request_start,
    #     response: response_end - response_start,
    #     dom_loading: dom_loading - response_start,
    #     dom_interactive: dom_interactive - dom_loading,
    #     dom_content_loaded_event: dom_content_loaded_event_end - dom_content_loaded_event_start,
    #     dom_complete: dom_complete - dom_content_loaded_event_end,
    #     load_event: load_event_end - load_event_start
    #   }
    # end
  end
end
