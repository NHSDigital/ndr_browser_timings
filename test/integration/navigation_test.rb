# frozen_string_literal: true

require 'test_helper'

class NavigationTest < ActionDispatch::IntegrationTest
  test 'should submit timing data via AJAX' do
    recordings = capture_recordings do
      visit '/'
      assert has_content?('The dummy says hello')
      assert has_content?('AJAX response')

      # Allow for the next scheduled sync to happen:
      sleep 2
    end

    assert(recordings.detect { |recording| recording.action == 'welcome' })
    assert(recordings.detect { |recording| recording.action == 'remote_welcome' })
    assert_equal 2, recordings.length
  end
end
