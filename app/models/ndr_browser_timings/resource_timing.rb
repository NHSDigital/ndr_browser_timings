module NdrBrowserTimings
  # Wraps window.performance.getEntry() objects
  #
  # These are similar to, but not the same as, the data structure
  # returned from the primary navigation.
  class ResourceTiming < PerformanceTiming
    # As defined by https://www.w3.org/TR/resource-timing-2/#sec-performanceresourcetiming
    RESOURCE_FIELDS = %w[
      initiatorType nextHopProtocol workerStart transferSize encodedBodySize decodedBodySize
    ].freeze

    RESOURCE_FIELDS.each do |field|
      attr_accessor field.underscore
      alias_attribute field, field.underscore if field != field.underscore
    end
  end
end
