class PostsController < ApplicationController
  def index
    @posts = PostsByDateQuery.call
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    SavePostCommand.call @post
    redirect_to action: :index
  end

  def edit
    @post = FindPostByIdQuery.call params[:id]
  end

  def update
    @post = FindPostByIdQuery.call params[:id]
    @post.attributes = post_params
    SavePostCommand.call @post
    redirect_to action: :index
  end

  def destroy
    DestroyPostCommand.call params[:id]
    redirect_to action: :index
  end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
