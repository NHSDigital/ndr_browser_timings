require 'test_helper'

module NdrBrowserTimings
  class PerformanceTimingTest < ActiveSupport::TestCase
    test 'should super camelcase or underscore' do
      timing = PerformanceTiming.new(navigationStart: 1)
      assert_equal 1, timing.navigationStart
      assert_equal 1, timing.navigation_start
    end

    test 'should drop non-supported fields' do
      assert_nothing_raised do
        timing = PerformanceTiming.new(customTimingAttributeFromBrowserX: 1)
        refute timing.respond_to?(:customTimingAttributeFromBrowserX)
      end
    end

    test 'should compute timeline figures when data available' do
      timing = PerformanceTiming.new(domainLookupStart: 1, domainLookupEnd: 3)
      assert_equal 2, timing.timeline[:dns]

      timing = PerformanceTiming.new(domainLookupStart: 1, domainLookupEnd: nil)
      assert_equal 0, timing.timeline[:dns]
    end

    test 'should be recordable? with controller and action' do
      assert PerformanceTiming.new(controller: 'foo', action: 'bar').recordable?
      refute PerformanceTiming.new(controller: 'foo').recordable?
    end
  end
end
