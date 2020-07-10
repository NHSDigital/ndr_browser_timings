require 'test_helper'
require 'ndr_browser_timings/recorders/logger'

module NdrBrowserTimings
  module Recorders
    class LoggerTest < ActiveSupport::TestCase
      setup do
        @recorder = Recorders::Logger.new
        @timing = PerformanceTiming.new(controller: :foo, action: :bar, request_start: 1)
      end

      test 'should log to Rails' do
        expected_message = 'NdrBrowserTimings {:controller=>:foo, :action=>:bar} {:unload=>0, :redirect=>0, :dns=>0, :connect=>0, :request=>0, :response=>0, :dom_loading=>0, :dom_interactive=>0, :dom_content_loaded_event=>0, :dom_complete=>0, :load_event=>0} {"requestStart"=>1}'

        Rails.logger.expects(:info).with(expected_message)
        @recorder.call(@timing)
      end
    end
  end
end
