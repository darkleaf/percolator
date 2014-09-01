module WebAuthentication
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?, :signed_out?
  end

  def sign_in
    session[:sign_in] = true
  end

  def sign_out
    session[:sign_in] = nil
  end

  def signed_in?
    session[:sign_in]
  end

  def signed_out?
    !signed_in?
  end

  def authenticate!
    redirect_to root_path unless signed_in?
  end
end
