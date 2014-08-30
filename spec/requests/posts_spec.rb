require 'rails_helper'

RSpec.describe 'posts', type: :request do
  context 'index page' do
    let (:post) { create :post }

    it 'render with 200 status' do
      get "/posts"
      expect(response).to be_success
    end
  end

  context 'show page' do
    let (:post) { create :post }

    it 'render with 200 status' do
      get "/posts/#{post.id}"
      expect(response).to be_success
    end
  end

  context 'new page' do
    it 'render with 200 status' do
      get "/posts/new"
      expect(response).to be_success
    end
  end

  context 'edit page' do
    let (:post) { create :post }

    it 'render with 200 status' do
      get "/posts/#{post.id}/edit"
      expect(response).to be_success
    end
  end

  context 'create action' do
    let (:post_attrs) { attributes_for :post }

    it 'create post' do
      post "/posts/", post: post_attrs
      posts = storage.posts_by_date_query.call
      expect(posts.one?).to be true
      expect(posts.first.attributes.slice(*post_attrs.keys)).to eq post_attrs
    end
  end

  context 'update action' do
    let (:post) { create :post }
    let (:post_attrs) { attributes_for :post }

    it 'update post' do
      patch "/posts/#{post.id}", post: post_attrs
      reloaded_post = storage.find_post_by_id_query.call post.id
      expect(reloaded_post.attributes.slice(*post_attrs.keys)).to eq post_attrs
    end
  end

  context 'delete action' do
    let (:post) { create :post }

    it 'delete post' do
      delete "/posts/#{post.id}"
      expect(storage.find_post_by_id_query.call(post.id)).to be nil
    end
  end
end
