require 'rails_helper'

RSpec.describe 'authentication', type: :request do
  [ %w[delete /favorite_pages/1],
    %w[get /posts/new], %w[post /posts], %w[get /posts/1/edit], %w[patch /posts/1], %w[delete /posts/1]].each do |item|
    it "for #{item.first}: #{item.last}" do
      send(item.first, item.last)
      expect(response).to redirect_to(root_path)
    end
  end
end
