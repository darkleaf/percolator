require 'rails_helper'

RSpec.describe ElasticStorage do
  context 'search' do
    let(:q) { 'test' }
    let!(:post) { create :post, title: 'test' }
    let!(:favorite_page) { create :favorite_page, title: 'test' }
    let(:results) { ElasticStorage::SearchQuery.call q }

    before { ElasticStorage.refresh_index }

    it 'work correctly' do
      expect(results.count).to eq 2
    end
  end
end
