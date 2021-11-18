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
    uid = request.env['omniauth.auth'][:uid]
    provider = request.env['omniauth.auth'][:provider]
    user = get_account(uid, provider)
    log_in user # luu session
    redirect_to root_path
  end

  private

  def get_account(uid, provider)
    User.find_or_create_by(uid: uid, provider: provider) do |u|
      firt_name = request.env['omniauth.auth'][:info][:first_name]
      last_name = request.env['omniauth.auth'][:info][:last_name]
      u.name = firt_name + ' ' + last_name
      u.email = request.env['omniauth.auth'][:info][:email]
      u.password = SecureRandom.hex(15)
      u.activated = true
    end
  end
end
