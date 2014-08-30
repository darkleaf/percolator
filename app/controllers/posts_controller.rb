class PostsController < ApplicationController
  def index
    @posts = storage.posts_by_date_query.call
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    storate.save_post_command.call @post
    redirect_to action: :index
  end

  def edit
    @post = storage.find_post_by_id_query.call params[:id]
  end

  def update
    @post = storage.find_post_by_id_query.call params[:id]
    @post.attributes = post_params
    storage.save_post_command.call @post
    redirect_to action: :index
  end

  def destroy
    storage.destroy_post_command.call params[:id]
    redirect_to action: :index
  end

private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
