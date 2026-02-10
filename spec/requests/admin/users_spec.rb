# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Users', type: :request do
  let(:admin_user) { create(:admin_user) }
  let!(:user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/users' do
    it 'returns http success' do
      get '/admin/users'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/users/:id' do
    it 'returns http success' do
      get "/admin/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/users/:id/edit' do
    it 'returns http success' do
      get "/admin/users/#{user.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/users/new' do
    it 'displays the form for creating a new User' do
      get '/admin/users/new'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Email')
      expect(response.body).to include('Password')
    end
  end

  describe 'POST /admin/users' do
    let(:valid_params) do
      {
        user: {
          email: 'newuser@example.com',
          password: 'password#123',
          password_confirmation: 'password#123'
        }
      }
    end

    it 'creates a new User' do
      expect do
        post '/admin/users', params: valid_params
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(%r{/admin/users/\d+})
    end
  end

  describe 'PUT /admin/users/:id' do
    let(:valid_params) do
      {
        user: {
          email: 'updateduser@example.com'
        }
      }
    end

    it 'updates an User' do
      put "/admin/users/#{user.id}", params: valid_params
      expect(response).to redirect_to(%r{/admin/users/\d+})
    end
  end

  describe 'DELETE /admin/users/:id' do
    it 'deletes an User' do
      expect do
        delete "/admin/users/#{user.id}"
      end.to change(User, :count).by(-1)

      expect(response).to redirect_to('/admin/users')
    end
  end
end
