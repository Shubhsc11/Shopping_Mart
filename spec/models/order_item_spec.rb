# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe '#total_price' do
    let(:user) { User.create(email: 'test@example.com', password: 'password', roles: 'customer') }
    let(:category) { Category.create(category_name: 'Test Category') }
    let(:subcategory) { Subcategory.create(subcategory_name: 'Test Subcategory', category: category) }
    let(:product) do
      Product.create(p_name: 'Test Product', p_price: 100, p_qty: 10, user: user, category: category,
                     subcategory: subcategory)
    end
    let(:order) { Order.create(user: user) }
    let(:order_item) { OrderItem.new(order: order, product: product, item_qty: 3) }

    it 'calculates total price based on quantity and product price' do
      expect(order_item.total_price).to eq(300)
    end
  end
end
