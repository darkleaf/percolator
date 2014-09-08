class Web::SearchesController < Web::ApplicationController
  skip_before_filter :authenticate!

  def show
    @result = storage.search_query.call params[:q]
  end
end
