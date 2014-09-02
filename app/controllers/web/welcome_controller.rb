class Web::WelcomeController < Web::ApplicationController
  skip_before_filter :authenticate!

  def index
    @posts = storage.posts_by_date_query.call
    @favorite_pages = storage.favorite_pages_by_date_query.call
  end
end
