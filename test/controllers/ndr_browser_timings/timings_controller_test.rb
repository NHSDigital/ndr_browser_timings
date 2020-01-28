require 'test_helper'

module NdrBrowserTimings
  class TimingsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    test "should get receive" do
      get timings_receive_url
      assert_response :success
    end

  end
end
