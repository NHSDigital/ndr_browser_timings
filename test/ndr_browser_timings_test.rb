# frozen_string_literal: true

require 'test_helper'

module NdrBrowserTimings
  class NdrBrowserTimingsTest < ActiveSupport::TestCase
    test 'exposes recorders' do
      assert_kind_of Array, NdrBrowserTimings.recorders

      capture_recordings do
        recorders = NdrBrowserTimings.recorders
        assert_equal 1, recorders.length
        assert_kind_of Proc, recorders.first
      end
    end

    test 'allows recordable timings to be recorded' do
      timing = PerformanceTiming.new(controller: 'foo', action: 'bar')
      recordings = capture_recordings { NdrBrowserTimings.record(timing) }

      assert_equal [timing], recordings
    end

    test 'does not record unrecordable timings' do
      timing = PerformanceTiming.new(controller: 'foo', action: nil)
      recordings = capture_recordings { NdrBrowserTimings.record(timing) }

      assert_equal [], recordings
    end
  end
end
