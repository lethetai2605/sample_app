# luu session truoc khi login
class SessionsController < ApplicationController
  # frozen_string_literal: true
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        log_in user # luu session
        # remember user # luu cookie
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # session[:session_token] = user.session_token
        redirect_to forwarding_url || user
      else
        message = 'Account not activated. '
        message += 'Check your email for the activation link.'
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  # require 'pry'

  def omniauth
    # binding.pry
    email = request.env['omniauth.auth'][:info][:email]
    provider = request.env['omniauth.auth'][:provider]
    uid = request.env['omniauth.auth'][:uid]
    @user = User.find_by(email: email)
    unless @user
      User.new_account(request, email)
      @user = User.find_by(email: email)
    end
    @provider = @user.providers.find_or_create_by(uid: uid, name: provider)
    log_in @user # luu session
    redirect_to root_path
  end
end
