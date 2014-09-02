require 'rails_helper'

RSpec.describe 'welcome page', type: :request do
  context 'index page' do
    let!(:post_model) { create :post }
    let!(:favorite_page) { create :favorite_page }

    it 'render with 200 status' do
      get "/"
      expect(response).to be_success
    end
  end
end
