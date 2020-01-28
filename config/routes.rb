# frozen_string_literal: true

NdrBrowserTimings::Engine.routes.draw do
  post '/', to: 'timings#receive'
end
