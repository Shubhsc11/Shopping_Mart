# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'redirects to my_cart_path' do
      get '/cart_items'
      expect(response).to redirect_to(my_cart_path)
    end
  end

  describe 'GET /show' do
    it 'redirects to my_cart_path' do
      cart_item = create(:cart_item, cart: cart)
      get "/cart_items/#{cart_item.id}"
      expect(response).to redirect_to(my_cart_path)
    end
  end

  describe 'POST /create' do
    let(:product) { create(:product) }

    it 'creates a new cart item if it dose not exist' do
      expect do
        post '/cart_items', params: { product_id: product.id }
      end.to change(CartItem, :count).by(1)
      expect(response).to redirect_to(products_path)
    end

    it 'increments quantity if cart item exists' do
      cart_item = create(:cart_item, cart: cart, product: product, item_qty: 1)
      post '/cart_items', params: { product_id: product.id }
      expect(cart_item.reload.item_qty).to eq(2)
      expect(response).to redirect_to(products_path)
    end

    it 'redirects to my_cart_path if action_key is buy' do
      post '/cart_items', params: { product_id: product.id, action_key: 'buy' }
      expect(response).to redirect_to(my_cart_path)
    end

    it 'handles validation errors' do
      allow(CartItem).to receive(:create!).and_raise(ActiveRecord::RecordInvalid.new(CartItem.new))
      post '/cart_items', params: { product_id: product.id }
      expect(flash[:alert]).to include('Failed to add product to cart')
    end
  end

  describe 'PATCH /add_quantity' do
    let(:cart_item) { create(:cart_item, cart: cart, item_qty: 1) }

    it 'increases the quantity' do
      post "/cart_items/#{cart_item.id}/add"
      expect(cart_item.reload.item_qty).to eq(2)
      expect(response).to redirect_to(my_cart_path)
    end
  end

  describe 'PATCH /reduce_quantity' do
    it 'decreases the quantity if greater than 1' do
      cart_item = create(:cart_item, cart: cart, item_qty: 2)
      post "/cart_items/#{cart_item.id}/reduce"
      expect(cart_item.reload.item_qty).to eq(1)
    end

    it 'does not decrease quantity if it is 1' do
      cart_item = create(:cart_item, cart: cart, item_qty: 1)
      post "/cart_items/#{cart_item.id}/reduce"
      expect(cart_item.reload.item_qty).to eq(1)
    end
  end

  describe 'DELETE /destroy' do
    let!(:cart_item) { create(:cart_item, cart: cart) }

    it 'destroys the cart item' do
      expect do
        delete "/cart_items/#{cart_item.id}"
      end.to change(CartItem, :count).by(-1)
      expect(response).to redirect_to(my_cart_path)
    end
  end
end
