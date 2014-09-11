class Web::SearchesController < Web::ApplicationController
  skip_before_filter :authenticate!

  def show
    @search_results = storage.search_query.call params[:q], page: params[:page], per_page: params[:per_page]
  end
end
