# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeliveryDetails', type: :request do
  let!(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:delivery_detail) { create(:delivery_detail, user: user) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user) }
  let(:cart_item) { create(:cart_item, cart: cart, product: product) }

  before do
    sign_in user
    # Ensure user has an order as the controller likely relies on it or we need to stub it
    # Controller uses `current_user.orders.last`, so creating one is sufficient
    order
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/delivery_details'
      expect(response).to have_http_status(:success)
    end

    it 'assigns cart and cart_items to initiate order' do
      order.update(status: 'draft') # Ensure the order is in draft status
      cart.cart_items << cart_item # Add cart item to cart
      get '/delivery_details'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/delivery_details/#{delivery_detail.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/delivery_details/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get "/delivery_details/#{delivery_detail.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'returns http success' do
      post '/delivery_details',
           params: { delivery_detail: { full_name: 'John Doe', address: '123 Main St', contact_no: '1234567890',
                                        user_id: user.id } }
      expect(response).to have_http_status(:found)
    end

    it 'returns http success with invalid params' do
      post '/delivery_details',
           params: { delivery_detail: { full_name: '', address: '', contact_no: '',
                                        user_id: user.id } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns http success when user has 5 delivery details' do
      5.times do
        create(:delivery_detail, user: user)
      end

      post '/delivery_details',
           params: { delivery_detail: { full_name: 'John Doe', address: '123 Main St', contact_no: '1234567890',
                                        user_id: user.id } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'PATCH /update' do
    it 'returns http success' do
      patch "/delivery_details/#{delivery_detail.id}",
            params: { delivery_detail: { full_name: 'John Doe', address: '123 Main St', contact_no: '1234567890',
                                         user_id: user.id } }
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE /destroy' do
    it 'returns http success' do
      delete "/delivery_details/#{delivery_detail.id}"
      expect(response).to have_http_status(:see_other)
    end
  end
end
