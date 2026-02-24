# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { should have_many(:cart_items).dependent(:destroy) }
    it { should have_many(:products).through(:cart_items) }
  end

  describe '#total_price' do
    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }
    let(:product1) { create(:product, p_price: 100) }
    let(:product2) { create(:product, p_price: 200) }

    before do
      create(:cart_item, cart: cart, product: product1, item_qty: 2)
      create(:cart_item, cart: cart, product: product2, item_qty: 1)
    end

    it 'calculates the total price of all cart items' do
      expect(cart.total_price).to eq(400)
    end
  end
end
