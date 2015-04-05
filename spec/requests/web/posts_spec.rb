require 'rails_helper'

RSpec.describe 'posts', type: :request do
  before(:each){ sign_in }

  context 'show page' do
    let (:post_model) { create :post }

    it 'render with 200 status' do
      get "/posts/#{post_model.to_param}"
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
    let (:post_model) { create :post }

    it 'render with 200 status' do
      get "/posts/#{post_model.to_param}/edit"
      expect(response).to be_success
    end
  end

  context 'create action' do
    let (:post_attrs) { attributes_for :post }

    it 'create post' do
      post "/posts/", post: post_attrs
      expect(Post).to be_exists(title: post_attrs[:title])
    end
  end

  context 'update action' do
    let (:post_model) { create :post }
    let (:post_attrs) { attributes_for :post }

    it 'update post' do
      patch "/posts/#{post_model.to_param}", post: post_attrs
      new_attrs = post_model.reload.attributes.symbolize_keys.slice(*post_attrs.keys)
      expect(new_attrs).to eq post_attrs
    end
  end

  context 'delete action' do
    let (:post_model) { create :post }

    it 'delete post' do
      delete "/posts/#{post_model.to_param}"
      expect(Post).to_not be_exists(post_model.id)
    end
  end
end
