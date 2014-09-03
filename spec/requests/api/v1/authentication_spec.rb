require 'rails_helper'

RSpec.describe 'api authentication', type: :request do
  [ %w[post /api/v1/stars] ].each do |item|
    it "for #{item.first}: #{item.last}" do
      send(item.first, item.last)
      expect(response.status).to be 403
    end
  end
end
