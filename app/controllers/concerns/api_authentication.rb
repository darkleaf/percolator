module ApiAuthentication
  extend ActiveSupport::Concern

  def authenticate!
    head :forbidden if Figaro.env.api_key != params[:api_key]
  end
end
