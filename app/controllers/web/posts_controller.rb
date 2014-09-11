class Web::PostsController < Web::ApplicationController
  skip_before_filter :authenticate!, only: %i[show]

  def show
    @post = storage.find_post_by_id_query.call params[:id]
    @materials = storage.search_query.call @post.favorite_pages_query
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    storage.save_post_command.call @post
    redirect_to post_path(@post)
  end

  def edit
    @post = storage.find_post_by_id_query.call params[:id]
  end

  def update
    @post = storage.find_post_by_id_query.call params[:id]
    @post.attributes = post_params
    storage.save_post_command.call @post
    redirect_to post_path(@post)
  end

  def destroy
    @post = storage.find_post_by_id_query.call params[:id]
    storage.destroy_post_command.call @post
    redirect_to root_path
  end

private
  def post_params
    params.require(:post).permit(:title, :content, :favorite_pages_query)
  end
end
