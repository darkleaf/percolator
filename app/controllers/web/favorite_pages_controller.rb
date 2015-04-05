class Web::FavoritePagesController < Web::ApplicationController
  skip_before_filter :authenticate!, only: %i[show]

  def show
    @favorite_page = ElasticStorage.get :favorite_page, params[:id]
  end

  def index
    @favorite_pages = FavoritePage.all
  end

  def destroy
    page = FavoritePage.destroy params[:id]
    respond_with page
  end
end
