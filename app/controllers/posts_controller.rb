class PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
    authorize @post
  end

  def new
    @topic = Topic.find(params[:topic_id])  
    @post = Post.new
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])  
    @post = current_user.posts.build(post_params)
    @post.topic = @topic # Why not: @post.topic_id = @topic.topic_id ???
    authorize @post

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
    @topic = @post.topic
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    @topic = @post.topic
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post

    if @post.destroy
      flash[:notice] = "\"#{title}\"was deleted succesfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
