class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])    
    @comment = current_user.comments.build(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    @comments = @post.comments
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment."
      render 'posts/show'#, locals: { topic: @topic, post: @post, comment: @comment, comments: @comments }
    end    
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment

    if @comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the comment."
      redirect_to [@topic, @post]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end