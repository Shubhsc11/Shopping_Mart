# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:subcategory) { create(:subcategory, category: category) }
  let(:product) { create(:product, user: user, category: category, subcategory: subcategory) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/products'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/products/#{product.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/products/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/products/#{product.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'returns http success' do
      post '/products',
           params: { product: { p_name: 'Product 1', p_price: 100, p_qty: 10, category_id: category.id,
                                subcategory_id: subcategory.id, user_id: user.id } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'PATCH /update' do
    it 'returns http success' do
      patch "/products/#{product.id}",
            params: { product: { p_name: 'Product 1', p_price: 100, p_qty: 10, category_id: category.id,
                                 subcategory_id: subcategory.id, user_id: user.id } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete "/products/#{product.id}"
      expect(response).to have_http_status(:see_other)
    end
  end
end
