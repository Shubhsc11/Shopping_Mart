# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/orders'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/orders/#{order.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    let(:product) { create(:product, user: user) }
    it 'returns http success' do
      post '/orders', params: { product_id: product.id }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete "/orders/#{order.id}"
      expect(response).to have_http_status(:see_other)
    end
  end
end
