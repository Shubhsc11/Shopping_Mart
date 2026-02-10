# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderItems', type: :request do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:product) { create(:product, user: user) }
  let(:order_item) { create(:order_item, order: order, product: product) }

  before do
    sign_in user
    order
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/order_items'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/order_items/#{order_item.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete "/order_items/#{order_item.id}"
      expect(response).to have_http_status(:found)
    end
  end

  describe 'POST /add_quantity' do
    it 'returns http success' do
      post "/order_items/#{order_item.id}/add"
      expect(response).to have_http_status(:found)
    end
  end

  describe 'POST /reduce_quantity' do
    it 'returns http success' do
      post "/order_items/#{order_item.id}/reduce"
      expect(response).to have_http_status(:found)
    end
  end
end
