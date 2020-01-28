require 'test_helper'

module NdrBrowserTimings
  class TimingsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test 'sending data via POST' do
      recordings = capture_recordings do
        post '/browser_timings', params: {
          pathname: '/',
          performance_timing: {
            domainLookupStart: 1,
            domainLookupEnd: 3
          }
        }

        assert_response :success
      end

      timing = recordings.first

      assert_kind_of PerformanceTiming, timing
      assert_equal 'application', timing.controller
      assert_equal 'welcome', timing.action
      assert_equal 2, timing.timeline[:dns]
    end
  end
end
