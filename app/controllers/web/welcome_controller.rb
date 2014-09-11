class Web::WelcomeController < Web::ApplicationController
  skip_before_filter :authenticate!

  def index
    @timeline = storage.timeline_query.call page: params[:page], per_page: params[:per_page]
  end
end
