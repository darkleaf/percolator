class Web::ApplicationController < ApplicationController
  include WebAuthentication
  before_filter :authenticate!
  self.responder = ApplicationResponder
  protect_from_forgery with: :exception
  respond_to :html
end
