require 'rails_helper'

RSpec.describe 'posts', type: :request do
  context 'show page' do
    let (:post_model) { create :post }

    it 'render with 200 status' do
      get "/posts/#{post_model.id}"
      expect(response).to be_success
    end
  end

  context 'new page for signed in user' do
    before(:each){ sign_in }

    it 'render with 200 status' do
      get "/posts/new"
      expect(response).to be_success
    end
  end

  context 'edit page' do
    before(:each){ sign_in }

    let (:post_model) { create :post }

    it 'render with 200 status' do
      get "/posts/#{post_model.id}/edit"
      expect(response).to be_success
    end
  end

  context 'create action' do
    before(:each){ sign_in }

    let (:post_attrs) { attributes_for :post }

    it 'create post' do
      post "/posts/", post: post_attrs
      posts = storage.search_query.call post_attrs[:title]
      expect(posts.one?).to be true
      expect(posts.first.title).to eq(post_attrs[:title])
    end
  end

  context 'update action' do
    before(:each){ sign_in }

    let (:post_model) { create :post }
    let (:post_attrs) { attributes_for :post }

    it 'update post' do
      patch "/posts/#{post_model.id}", post: post_attrs
      reloaded_post = storage.find_post_by_id_query.call post_model.id
      expect(reloaded_post.attributes.slice(*post_attrs.keys)).to eq post_attrs
    end
  end

  context 'delete action' do
    before(:each){ sign_in }

    let (:post_model) { create :post }

    it 'delete post' do
      delete "/posts/#{post_model.id}"
      expect(storage.find_post_by_id_query.call(post_model.id)).to be nil
    end
  end
end
