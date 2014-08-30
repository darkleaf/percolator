require 'rails_helper'

RSpec.describe ElasticStorage do
  after :each do
    ElasticStorage.clear_command.call
  end

  let (:client) { ElasticStorage::Client.client }

  context 'save_post_command' do
    let (:post) { build :post }

    it 'work correctly' do
      ElasticStorage.save_post_command.call post

      expect(client.exists index: 'documents', type: 'post', id: post.id).to be true
    end
  end

  context 'destroy_post_command' do
    let (:post) { build :post }

    before :each do
      ElasticStorage.save_post_command.call post
    end

    it 'work correctly' do
      ElasticStorage.destroy_post_command.call post

      expect(client.exists index: 'documents', type: 'post', id: post.id).to be false
    end
  end
end
