# frozen_string_literal: true

module NdrBrowserTimings
  class Engine < ::Rails::Engine
    isolate_namespace NdrBrowserTimings

    initializer 'ndr_browser_timings.inject_helpers' do |app|
      app.config.to_prepare do
        ::ApplicationHelper.include(MetaTagHelper)
      end
    end
  end
end
