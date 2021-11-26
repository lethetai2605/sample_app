# app
class ApplicationController < ActionController::Base
  # frozen_string_literal: true
  include SessionsHelper

  rescue_from CanCan::AccessDenied do
    flash[:danger] = 'Access denied!'
    redirect_to root_url
  end
end
