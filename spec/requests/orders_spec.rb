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

    context 'when owner' do
      let(:owner) { create(:user, roles: 'owner') }
      let(:product) { create(:product, user: owner) }
      let!(:order_item) { create(:order_item, order: order, product: product) }

      before { sign_in owner }

      it 'returns orders containing their products' do
        get '/orders'
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/orders/#{order.id}"
      expect(response).to have_http_status(:success)
    end

    it 'redirects if order not found' do
      get '/orders/999'
      expect(response).to redirect_to(orders_path)
      expect(flash[:alert]).to eq('Order not found')
    end

    context 'when owner' do
      let(:owner) { create(:user, roles: 'owner') }
      let(:product) { create(:product, user: owner) }
      let(:order2) { create(:order, user: user) }
      let!(:order_item) { create(:order_item, order: order2, product: product) }

      before { sign_in owner }

      it 'returns success for order containing their product' do
        get "/orders/#{order2.id}"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST /create' do
    let(:product) { create(:product) }

    it 'creates a new order if none exists' do
      expect do
        post '/orders', params: { product_id: product.id }
      end.to change(Order, :count).by(1)
    end

    it 'adds item to last order if it exists' do
      existing_order = create(:order, user: user)
      post '/orders', params: { product_id: product.id }
      expect(existing_order.order_items.count).to eq(1)
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a draft order' do
      delete "/orders/#{order.id}"
      expect(response).to redirect_to(orders_path)
      expect(flash[:notice]).to eq('Order was successfully cancelled.')
    end

    it 'cancels a placed order and refunds points' do
      order.update(status: 'placed')
      user.update(points: 100)
      product = create(:product, p_price: 50)
      create(:order_item, order: order, item_price: 50, item_qty: 1, product: product)

      delete "/orders/#{order.id}"
      expect(order.reload.status).to eq('cancelled')
      expect(user.reload.points).to eq(150)
    end

    it 'cannot cancel a shipped order' do
      order.update(status: 'shipped')
      delete "/orders/#{order.id}"
      expect(flash[:alert]).to include('Cannot cancel order')
    end

    it 'order not found or unauthorized' do
      delete '/orders/0'
      expect(flash[:alert]).to eq('Order not found')
    end
  end

  describe 'PATCH /update' do
    let(:delivery_detail) { create(:delivery_detail, user: user) }

    it 'places the order successfully' do
      create(:order_item, order: order, product: create(:product, p_qty: 10), item_qty: 1)
      user.update(points: 1000)

      patch "/orders/#{order.id}", params: { delivery_detail_id: delivery_detail.id }

      expect(order.reload.status).to eq('placed')
      expect(response).to redirect_to(order_path(order))
    end
  end
end
