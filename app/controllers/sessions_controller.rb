class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      if user.activated?
        forwarding_url = session[:forwarding_url]
        reset_session
        log_in user #luu session
      # remember user # luu cookie
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # session[:session_token] = user.session_token
        redirect_to forwarding_url || user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
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
    user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
      u.name = request.env['omniauth.auth'][:info][:first_name] + ' ' + request.env['omniauth.auth'][:info][:last_name]
      u.email = request.env['omniauth.auth'][:info][:email]
      u.password = SecureRandom.hex(15)
      u.activated = true
    end
    log_in user #luu session
    redirect_to root_path

    # if params[:provider] == 'facebook'
    # user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
    #   u.name = request.env['omniauth.auth'][:info][:first_name] + ' ' + request.env['omniauth.auth'][:info][:last_name]
    #   u.email = request.env['omniauth.auth'][:info][:email]
    #   u.password = SecureRandom.hex(15)
    #   u.activated = true
    #   end
    # log_in user #luu session
    # redirect_to root_path
    # end
  end
end
