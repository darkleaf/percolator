require 'rails_helper'

RSpec.describe 'api v1 stars', type: :request do
  context 'create action' do
    let(:url) { generate :url }
    let(:html) { generate :page_html }
    let(:url_digest) { UrlDigestGenerator.call url }
    let!(:stub) { stub_request(:get, url).to_return(body: html) }
    let(:params) { {star: { url: url }, api_key: Figaro.env.api_key} }

    it 'fetch page' do
      post "/api/v1/stars/", params
      expect(stub).to have_been_requested
    end

    it 'save favorite page' do
      post "/api/v1/stars/", params
      page = FavoritePage.find_by! url_digest: url_digest
      expect(page.title).to be
      expect(page.description).to be
      expect(page.keywords).to be
      expect(page.content).to be
      expect(page.url).to be
    end
  end
end
