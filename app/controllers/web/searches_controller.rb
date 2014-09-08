class Web::SearchesController < Web::ApplicationController
  skip_before_filter :authenticate!

  def show
    @search_results = storage.search_query.call params[:q]
  end
end
