class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was saved."
    else
      flash[:error] = "There was an error saving the comment."
    end

    redirect_to [@topic, @post]
  end

private

  def comment_params
    params.require(:comment).permit(:body)
  end
end