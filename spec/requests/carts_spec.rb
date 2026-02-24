# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:user) { create(:user) }
  let(:cart) { user.cart }

  before do
    sign_in user
  end

  describe 'GET /my_cart' do
    it 'returns http success' do
      get my_cart_path
      expect(response).to have_http_status(:success)
    end

    it 'assigns @cart_items' do
      product = create(:product)
      create(:cart_item, cart: cart, product: product)
      get my_cart_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE /carts/:id' do
    it 'destroys cart items and redirects' do
      product = create(:product)
      create(:cart_item, cart: cart, product: product)

      expect do
        delete cart_path(cart)
      end.to change(CartItem, :count).by(-1)

      expect(response).to redirect_to(my_cart_path)
      expect(response).to have_http_status(:see_other)
    end

    it 'destroys draft orders associated with cart products' do
      product = create(:product)
      create(:cart_item, cart: cart, product: product)
      order = create(:order, user: user, status: 'draft')
      create(:order_item, order: order, product: product)

      expect do
        delete cart_path(cart)
      end.to change(Order, :count).by(-1)
    end

    it 'does not destroy non-draft orders' do
      product = create(:product)
      create(:cart_item, cart: cart, product: product)
      order = create(:order, user: user, status: 'placed')
      create(:order_item, order: order, product: product)

      expect do
        delete cart_path(cart)
      end.not_to change(Order, :count)
    end
  end
end
