# micropost
class MicropostsController < ApplicationController
  # frozen_string_literal: true
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'Micropost deleted'
    if request.referrer.nil? || request.referrer == microposts_url
      redirect_to root_url
    else
      redirect_to request.referrer # back lai url trc khi xoa
    end
  end

  def logged_in_user
    unless logged_in?
      store_location # neu chua login thi cung luu cai url dinh vao
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def read_post
    @micropost = Micropost.find(params[:id])
    if @micropost.user.id == current_user.id
      @micropost.update(is_read: true)
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
