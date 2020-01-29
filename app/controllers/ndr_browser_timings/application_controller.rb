# frozen_string_literal: true

module NdrBrowserTimings
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :check_authentication

    private

    def check_authentication
      return if NdrBrowserTimings.check_current_user_authentication.call(self)

      head :unauthorized
    end
  end
end
