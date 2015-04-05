class Web::FavoritePagesController < Web::ApplicationController
  def index
    @favorite_pages = FavoritePage.all
  end

  def destroy
    page = FavoritePage.destroy params[:id]
    respond_with page
  end
end
