# ReactionsController
class ReactionsController < ApplicationController
  # frozen_string_literal: true
  before_action :find_post

  def create
    if @micropost.user_already_liked? current_user
      @react_post = @micropost.react_posts.where(user_id: current_user.id)
      @react_post.update(reaction_id: params[:react_id])
    else
      @react_post = @micropost.react_posts.new
      @react_post.user_id = current_user.id
      @react_post.reaction_id = params[:react_id]
      @react_post.save
      NotificationMailer.new_notification(@react_post).deliver_now
      @micropost.user.update(read_notification: false)
      @micropost.update(is_read: false)
    end
  end

  def destroy
    if @micropost.user_already_liked? current_user
      @react_post = @micropost.react_posts.find_by(user_id: current_user.id)
      @react_post.destroy_notification
      @react_post.destroy
    end
  end

  private

  def find_post
    @micropost = Micropost.find(params[:micropost_id])
  end
end
