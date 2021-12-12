class ReactionsController < ApplicationController
  before_action :find_post

  def create
    if User.already_liked?(current_user, @micropost.id)
      @react_post = @micropost.react_posts.where(user_id: current_user.id, micropost_id: params[:micropost_id])
      if @react_post.update(reaction_id: params[:current_reaction_id])
      end
     
    else
      @react_post = @micropost.react_posts.new(micropost_id: params[:micropost_id])
      @react_post.user_id = current_user.id
      @react_post.reaction_id = params[:current_reaction_id]
    
      if @react_post.save
      end
    end
  end

  def destroy
    if User.already_liked?(current_user, @micropost.id)
      @react_post = @micropost.react_posts.find_by(micropost_id: params[:micropost_id])
      if @react_post.destroy
      end
    end
  end

  private

  def find_post
    @micropost = Micropost.find(params[:micropost_id])
  end

  def reaction_params
    params.require(:reaction).permit(:current_react)
  end
end
