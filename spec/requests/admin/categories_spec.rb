# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Categories', type: :request do
  let(:admin_user) { create(:admin_user) }
  let!(:category) { create(:category) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/categories' do
    it 'returns http success' do
      get '/admin/categories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/categories/:id' do
    it 'returns http success' do
      get "/admin/categories/#{category.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/categories/:id/edit' do
    it 'returns http success' do
      get "/admin/categories/#{category.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/categories/new' do
    it 'displays the form for creating a new Category' do
      get '/admin/categories/new'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Category name')
    end
  end

  describe 'POST /admin/categories' do
    let(:valid_params) do
      {
        category: {
          category_name: 'New Category'
        }
      }
    end

    it 'creates a new Category' do
      expect do
        post '/admin/categories', params: valid_params
      end.to change(Category, :count).by(1)

      expect(response).to redirect_to(%r{/admin/categories/\d+})
    end
  end

  describe 'PUT /admin/categories/:id' do
    let(:valid_params) do
      {
        category: {
          name: 'Updated Category'
        }
      }
    end

    it 'updates an Category' do
      put "/admin/categories/#{category.id}", params: valid_params
      expect(response).to redirect_to(%r{/admin/categories/\d+})
    end
  end

  describe 'DELETE /admin/categories/:id' do
    it 'deletes an Category' do
      expect do
        delete "/admin/categories/#{category.id}"
      end.to change(Category, :count).by(-1)

      expect(response).to redirect_to('/admin/categories')
    end
  end
end
