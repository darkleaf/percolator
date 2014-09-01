require 'rails_helper'

RSpec.describe 'sessions', type: :request do
  let (:post_attrs) { attributes_for :post }
  let (:correct_params) { {session: {password: Figaro.env.password}} }
  let (:wrong_params) { {session: {password: 'wrong_password'}} }

  context 'create action' do
    it 'redirect to root' do
      post "/session", correct_params
      expect(response).to redirect_to(root_path)
    end

    it 'create session' do
      post "/session", correct_params
      expect(session[:sign_in]).to be true
    end

    it 'not create session' do
      post "/session", wrong_params
      expect(session[:sign_in]).to be nil
    end
  end

  context 'delete action' do
    before :each do
      post "/session", correct_params
    end

    it 'delete post' do
      delete "/session"
      expect(session[:sign_in]).to be nil
    end
  end
end
