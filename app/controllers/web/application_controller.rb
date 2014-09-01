class Web::ApplicationController < ApplicationController
  include WebAuthentication
  before_filter :authenticate!
  protect_from_forgery with: :exception
end
