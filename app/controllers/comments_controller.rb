class CommentsController < ApplicationController
  before_action :require_authentication

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(comment_params)
    @comment.user = current_user
    @comment.published_at = Time.current

    if @comment.save
      redirect_to blog_path(@blog), notice: "Comment posted!"
    else
      redirect_to blog_path(@blog), alert: "Failed to post comment."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
