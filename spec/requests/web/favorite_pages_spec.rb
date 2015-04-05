require 'rails_helper'

RSpec.describe 'favorite_pages', type: :request do
  before(:each){ sign_in }

  context 'index page' do
    let! (:favorite_page) { create :favorite_page }

    it 'render with 200 status' do
      get '/favorite_pages'
      expect(response).to be_success
    end
  end

  context 'delete action' do
    let (:favorite_page) { create :favorite_page }

    it 'delete favorite_page' do
      delete "/favorite_pages/#{favorite_page.to_param}"
      expect(FavoritePage).to_not be_exists(favorite_page.id)
    end
  end
end
