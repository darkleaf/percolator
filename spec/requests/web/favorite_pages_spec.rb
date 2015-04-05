require 'rails_helper'

RSpec.describe 'favorite_pages', type: :request do
  before(:each){ sign_in }

  context 'delete action' do
    let (:favorite_page) { create :favorite_page }

    it 'delete favorite_page' do
      delete "/favorite_pages/#{favorite_page.to_param}"
      expect(FavoritePage).to_not be_exists(favorite_page.id)
    end
  end
end
