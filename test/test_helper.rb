# frozen_string_literal: true

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require_relative '../test/dummy/config/environment'
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../test/dummy/db/migrate', __dir__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../db/migrate', __dir__)
require 'rails/test_help'

ENV['INTEGRATION_DRIVER'] ||= 'chrome_headless'
require 'ndr_dev_support/integration_testing'
Capybara.server = :webrick

# Filter out the backtrace from minitest while preserving the one from other libraries.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('fixtures', __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + '/files'
  ActiveSupport::TestCase.fixtures :all
end

ActiveSupport::TestCase.class_eval do
  def capture_recordings
    original = NdrBrowserTimings.recorders

    result = []
    NdrBrowserTimings.recorders = [->(timing) { result << timing }]
    yield
    result
  ensure
    NdrBrowserTimings.recorders = original
  end
end
