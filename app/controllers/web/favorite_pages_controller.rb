class Web::FavoritePagesController < Web::ApplicationController
  skip_before_filter :authenticate!, only: %i[show]

  def show
    @favorite_page = storage.find_favorite_page_by_id_query.call params[:id]
  end

  def destroy
    @favorite_page = storage.find_favorite_page_by_id_query.call params[:id]
    storage.destroy_favorite_page_command.call @favorite_page
    redirect_to root_path
  end
end
