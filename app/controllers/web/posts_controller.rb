class Web::PostsController < Web::ApplicationController
  skip_before_filter :authenticate!, only: %i[show]

  def show
    @post = storage.find_post_by_id_query.call params[:id]
    @materials = storage.search_query.call @post.similar_query
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create post_params
    respond_with @post
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    @post.update post_params
    respond_with @post
  end

  def destroy
    @post = Post.destroy params[:id]
    respond_with @post
  end

private
  def post_params
    params.require(:post).permit(:title, :content, :relative_query)
  end
end
