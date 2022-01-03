# This is User controller
class UsersController < ApplicationController
  # frozen_string_literal: true
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  # before_action :admin_user, only: :destroy
  load_and_authorize_resource
  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # redirect_to root_url and return unless @user.activated
  end

  def new
    # @user = User.new
  end

  def create
    # @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url

      # reset_session
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Confirms a logged-in user
  def logged_in_user
    # return if logged_in?
    return if user_signed_in?

    store_location # neu chua login thi cung luu cai url dinh vao
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  # def admin_user
  #   redirect_to(root_url) unless current_user.admin?
  # end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def export
    csv1 = ExportCsvService.new Micropost.recent_posts(params[:id]), Micropost::MICROPOST_ATTRIBUTES
    csv2 = ExportCsvService.new Relationship.followings(params[:id]), Relationship::FOLLOWING_ATTRIBUTES
    csv3 = ExportCsvService.new Relationship.followers(params[:id]), Relationship::FOLLOWER_ATTRIBUTES
    zip = Zip::OutputStream.write_buffer do |zipfile|
      zipfile.put_next_entry 'export_posts.csv'
      zipfile.print csv1.perform
      zipfile.put_next_entry 'export_followings.csv'
      zipfile.print csv2.perform
      zipfile.put_next_entry 'export_followers.csv'
      zipfile.print csv3.perform
    end
    zip.rewind
    send_data zip.read, filename: 'export_user.zip'
  end

  def read_notification
    @user.update(read_notification: true)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :admin)
  end
end
