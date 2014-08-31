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

  context 'find_post_by_id_query' do
    let (:post) { build :post }

    before :each do
      ElasticStorage.save_post_command.call post
    end

    it 'work correctly' do
      fetched_post = ElasticStorage.find_post_by_id_query.call post.id
      expect(fetched_post.attributes).to include post.attributes
    end

    it 'return nil in silent mode' do
      fetched_post = ElasticStorage.find_post_by_id_query.call 'unsaved_post_id', silent: true
      expect(fetched_post).to be nil
    end

    it 'raise error if silent mode off' do
      expect{ElasticStorage.find_post_by_id_query.call 'unsaved_post_id'}.to raise_error ElasticStorage::NotFound
    end
  end

  context 'posts_by_date_query' do
    let (:past_post) { build :post, published_at: 1.day.ago.to_datetime }
    let (:future_post) { build :post, published_at: 1.day.since.to_datetime }

    before :each do
      ElasticStorage.save_post_command.call past_post
      ElasticStorage.save_post_command.call future_post
    end

    it 'work correctly' do
      posts = ElasticStorage.posts_by_date_query.call

      expect(posts.length).to eq 2
      expect(posts.first.attributes).to include future_post.attributes
      expect(posts.last.attributes).to include past_post.attributes
    end
  end






  context 'save_favorite_page_command' do
    let (:favorite_page) { build :favorite_page }

    it 'work correctly' do
      ElasticStorage.save_favorite_page_command.call favorite_page

      expect(client.exists index: 'documents', type: 'favorite_page', id: favorite_page.id).to be true
    end
  end

  context 'destroy_favorite_page_command' do
    let (:favorite_page) { build :favorite_page }

    before :each do
      ElasticStorage.save_favorite_page_command.call favorite_page
    end

    it 'work correctly' do
      ElasticStorage.destroy_favorite_page_command.call favorite_page

      expect(client.exists index: 'documents', type: 'favorite_page', id: favorite_page.id).to be false
    end
  end

  context 'find_favorite_page_by_id_query' do
    let (:favorite_page) { build :favorite_page }

    before :each do
      ElasticStorage.save_favorite_page_command.call favorite_page
    end

    it 'work correctly' do
      fetched_favorite_page = ElasticStorage.find_favorite_page_by_id_query.call favorite_page.id
      expect(fetched_favorite_page.attributes).to include favorite_page.attributes
    end

    it 'return nil in silent mode' do
      fetched_favorite_page = ElasticStorage.find_favorite_page_by_id_query.call 'unsaved_favorite_page_id', silent: true
      expect(fetched_favorite_page).to be nil
    end

    it 'raise error if silent mode off' do
      expect{ElasticStorage.find_favorite_page_by_id_query.call 'unsaved_favorite_page_id'}.to raise_error ElasticStorage::NotFound
    end
  end

  context 'favorite_pages_by_date_query' do
    let (:past_favorite_page) { build :favorite_page, published_at: 1.day.ago.to_datetime }
    let (:future_favorite_page) { build :favorite_page, published_at: 1.day.since.to_datetime }

    before :each do
      ElasticStorage.save_favorite_page_command.call past_favorite_page
      ElasticStorage.save_favorite_page_command.call future_favorite_page
    end

    it 'work correctly' do
      favorite_pages = ElasticStorage.favorite_pages_by_date_query.call

      expect(favorite_pages.length).to eq 2
      expect(favorite_pages.first.attributes).to include future_favorite_page.attributes
      expect(favorite_pages.last.attributes).to include past_favorite_page.attributes
    end
  end
end
