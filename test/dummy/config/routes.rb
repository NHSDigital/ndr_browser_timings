# frozen_string_literal: true

Rails.application.routes.draw do
  mount NdrBrowserTimings::Engine => '/browser_timings'

  root 'application#welcome'
  get 'remote_welcome', to: 'application#remote_welcome', as: 'ajax'
end
