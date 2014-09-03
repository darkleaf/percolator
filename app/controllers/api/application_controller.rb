class Api::ApplicationController < ApplicationController
  include ApiAuthentication
  before_filter :authenticate!
  protect_from_forgery
end
