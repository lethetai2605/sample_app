# RepliesController
class RepliesController < ApplicationController
  # frozen_string_literal: true
  before_action :logged_in_user, only: %i[create destroy]
  before_action :check_user_replies, only: :destroy

  def new
    @micropost = Micropost.find(params[:micropost_id])
    @reply = @micropost.replies.new
  end

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @reply = @micropost.replies.new(replies_params)
    @reply.user_id = current_user.id
    # binding.pry
    if @reply.save
    else
      flash[:danger] = 'Comment too long'
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Reply.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def logged_in_user
    unless logged_in?
      store_location # neu chua login thi cung luu cai url dinh vao
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  private

  def replies_params
    params.require(:reply).permit(:content)
  end

  def check_user_replies
    @reply = current_user.replies.find_by(id: params[:id])
    redirect_to root_url if @reply.nil?
  end
end
