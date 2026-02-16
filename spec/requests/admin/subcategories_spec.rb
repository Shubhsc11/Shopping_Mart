# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Subcategories', type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:category) { create(:category) }
  let!(:subcategory) { create(:subcategory, category: category) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/subcategories' do
    it 'returns http success' do
      get '/admin/subcategories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/subcategories/:id' do
    it 'returns http success' do
      get "/admin/subcategories/#{subcategory.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/subcategories/:id/edit' do
    it 'returns http success' do
      get "/admin/subcategories/#{subcategory.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/subcategories/new' do
    it 'displays the form for creating a new Subcategory' do
      get '/admin/subcategories/new'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Name')
    end
  end

  describe 'POST /admin/subcategories' do
    let(:valid_params) do
      {
        subcategory: {
          subcategory_name: 'New Subcategory',
          category_id: category.id
        }
      }
    end

    it 'creates a new Subcategory' do
      expect do
        post '/admin/subcategories', params: valid_params
      end.to change(Subcategory, :count).by(1)

      expect(response).to redirect_to(%r{/admin/subcategories/\d+})
    end
  end

  describe 'PUT /admin/subcategories/:id' do
    let(:valid_params) do
      {
        subcategory: {
          subcategory_name: 'Updated Subcategory'
        }
      }
    end

    it 'updates an Subcategory' do
      put "/admin/subcategories/#{subcategory.id}", params: valid_params
      expect(response).to redirect_to(%r{/admin/subcategories/\d+})
    end
  end

  describe 'DELETE /admin/subcategories/:id' do
    it 'deletes an Subcategory' do
      expect do
        delete "/admin/subcategories/#{subcategory.id}"
      end.to change(Subcategory, :count).by(-1)

      expect(response).to redirect_to('/admin/subcategories')
    end
  end
end
