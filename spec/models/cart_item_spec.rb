# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
    it { should belong_to(:order).optional }
  end

  describe '#total_price' do
    it 'calculates total price based on item quantity and product price' do
      product = create(:product, p_price: 10.0)
      cart_item = create(:cart_item, product: product, item_qty: 3)

      expect(cart_item.total_price).to eq(30.0)
    end
  end
end
