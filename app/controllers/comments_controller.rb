class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create destroy ]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(:author_id => current_user.id))
    @comment.author = current_user
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize @comment
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
