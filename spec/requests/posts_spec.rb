require 'rails_helper'

RSpec.describe 'posts', type: :request do
  context 'index page' do
    before :context do
      @post = Post.new title: 'title', content: 'content'
      CreatePostCommand.call post
      get "/posts"
    end

    it 'render with 200 status' do
      expect(response).to be_success
    end
  end
end