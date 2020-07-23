# frozen_string_literal: true

require 'test_helper'

class MetaTagHelperTest < ActionView::TestCase
  include NdrBrowserTimings::Engine.helpers

  test 'should produce correct default tags' do
    actual = ndr_browser_timings_meta_tag

    assert_equal <<~HTML.strip, actual
      <meta name="ndr_broser_timings_endpoint" content="/browser_timings/" /><meta name="ndr_broser_timings_sample_rate" content="1.0" />
    HTML
  end

  test 'should produce correct sampling tags' do
    actual = ndr_browser_timings_meta_tag(sample_rate: 0.33)

    assert_equal <<~HTML.strip, actual
      <meta name="ndr_broser_timings_endpoint" content="/browser_timings/" /><meta name="ndr_broser_timings_sample_rate" content="0.33" />
    HTML
  end
end
