require 'rails_helper'

RSpec.describe 'favorite_pages', type: :request do
  context 'show page' do
    let (:favorite_page) { create :favorite_page }

    it 'render with 200 status' do
      get "/favorite_pages/#{favorite_page.id}"
      expect(response).to be_success
    end
  end

  context 'delete action' do
    before(:each){ sign_in }
    let (:favorite_page) { create :favorite_page }

    it 'delete favorite_page' do
      delete "/favorite_pages/#{favorite_page.id}"
      expect(storage.find_favorite_page_by_id_query.call(favorite_page.id)).to be nil
    end
  end
end
