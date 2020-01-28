# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def welcome
    @message = 'The dummy says hello!'
  end

  def remote_welcome
    render plain: 'AJAX response'
  end
end
