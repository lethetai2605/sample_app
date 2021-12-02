class ReactionsController < ApplicationController
  before_action :find_post

  def create
    if already_liked?
      redirect_to root_path
    else
      @react_post = @micropost.react_posts.new(micropost_id: params[:micropost_id])
      @react_post.user_id = current_user.id
      @react_post.reaction_id = '1'
      if @react_post.save
        redirect_to root_path
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
        render 'static_pages/home'
      end
    end
  end

  def destroy
    if already_liked?
      @react_post = @micropost.react_posts.find_by(micropost_id: params[:micropost_id])
      if @react_post.destroy
        redirect_to root_path
      end
    end
  end

  private

  def find_post
    @micropost = Micropost.find(params[:micropost_id])
  end

  def already_liked?
    ReactPost.where(user_id: current_user.id, micropost_id: params[:micropost_id]).exists?
  end
end
