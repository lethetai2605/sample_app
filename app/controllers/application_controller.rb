# app
class ApplicationController < ActionController::Base
  # frozen_string_literal: true
  include SessionsHelper

  rescue_from CanCan::AccessDenied do
    flash[:danger] = 'Access denied!'
    redirect_to root_url
  end

  def logged_in_user
    unless logged_in?
      store_location # neu chua login thi cung luu cai url dinh vao
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end
end
