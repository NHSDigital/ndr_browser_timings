require 'test_helper'
require 'ndr_browser_timings/recorders/ndr_stats'

module NdrBrowserTimings
  module Recorders
    class NdrStatsTest < ActiveSupport::TestCase
      setup do
        @recorder = Recorders::NdrStats.new(raise_unless_configured: false)
        @timing = PerformanceTiming.new(controller: :foo, action: :bar)
      end

      test 'should raise unless configured by default' do
        exception = assert_raises(RuntimeError) { Recorders::NdrStats.new }
        assert_match(/ndr_stats is not configured/, exception.message)
      end

      test 'should log to NdrStats' do
        @timing.stubs(timeline: { dns: 1 })
        NdrStats.expects(:timing).with(:dns, 1, controller: :foo, action: :bar)

        @recorder.call(@timing)
      end
    end
  end
end
