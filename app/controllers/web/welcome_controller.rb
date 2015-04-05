class Web::WelcomeController < Web::ApplicationController
  skip_before_filter :authenticate!

  def index
    @results = ElasticStorage::SearchQuery.call params[:q], page: params[:page], per_page: params[:per_page]
  end
end
