require_dependency 'ndr_browser_timings/application_controller'

module NdrBrowserTimings
  # controller for receiving timings sent from clients' browsers.
  class TimingsController < ApplicationController
    # POST "/"
    def receive
      if params.key?(:performance_timing)
        source = source_route(params[:pathname])
        timing = PerformanceTiming.new(source.merge(performance_timing))
        NdrBrowserTimings.record(timing)
      elsif params.key?(:resource_timings)
        resource_timings.each do |data|
          source = source_route(data.delete('name'))
          timing = ResourceTiming.new(source.merge(data))
          NdrBrowserTimings.record(timing)
        end
      end

      head :no_content
    end

    private

    def resource_timings
      params.require(:resource_timings).map(&:permit!)
    end

    def performance_timing
      params.require(:performance_timing).permit!
    end

    def source_route(path)
      Rails.application.routes.recognize_path(path)
    rescue ActionController::RoutingError
      {}
    end
  end
end
