require 'rails_helper'

RSpec.describe ElasticStorage do
  after :each do
    ElasticStorage.clear
  end

  context 'search' do
    let(:q) { 'test' }
    let!(:post) { create :post, title: 'test' }
    let!(:favorite_page) { create :favorite_page, title: 'test' }
    let(:results) { ElasticStorage::SearchQuery.call q }

    it 'work correctly' do
      expect(results.count).to eq 2
    end
  end
end
