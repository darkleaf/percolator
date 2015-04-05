class Web::PostsController < Web::ApplicationController
  skip_before_filter :authenticate!, only: %i[show]

  def show
    @post = ElasticStorage.get(:post, params[:id])
    @materials =
      if @post.relative_query_without_self.present?
        ElasticStorage::SearchQuery.call @post.relative_query_without_self, per_page: 5
      else
        StorageCollection.new []
      end
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
    respond_with @post, location: root_path
  end

private
  def post_params
    params.require(:post).permit(:title, :content, :relative_query)
  end
end
