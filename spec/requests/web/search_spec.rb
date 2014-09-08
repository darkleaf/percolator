require 'rails_helper'

RSpec.describe 'search', type: :request do
  context 'page' do
    let (:favorite_page) { create :favorite_page }
    let (:post) { create :post }

    it 'render with 200 status' do
      get "/search"
      expect(response).to be_success
    end
  end
end
