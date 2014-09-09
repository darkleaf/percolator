class Web::WelcomeController < Web::ApplicationController
  skip_before_filter :authenticate!

  def index
    @timeline = storage.timeline_query.call
  end
end
