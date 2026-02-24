# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:order_items).class_name('OrderItem').dependent(:destroy) }
    it { should have_many(:products).through(:order_items).class_name('Product') }
    it { should belong_to(:delivery_detail).class_name('DeliveryDetail').optional }
  end

  describe 'enums' do
    it {
      should define_enum_for(:status).with_values(draft: 'draft', placed: 'placed', confirmed: 'confirmed',
                                                  shipped: 'shipped', delivered: 'delivered', cancelled: 'cancelled')
                                     .backed_by_column_of_type(:string)
    }
  end

  describe 'callbacks' do
    it 'sets default status to created' do
      order = Order.new
      expect(order.status).to eq('draft')
    end
  end

  describe '#sub_total' do
    let(:user) { User.create(email: 'test@example.com', password: 'password', roles: 'customer') }
    let(:category) { Category.create(category_name: 'Test Category') }
    let(:subcategory) { Subcategory.create(subcategory_name: 'Test Subcategory', category: category) }
    let(:order) { Order.create(user: user) }
    let(:product) do
      Product.create(p_name: 'Test Product', p_price: 100, p_qty: 10, user: user, category: category,
                     subcategory: subcategory)
    end
    let!(:order_item) { OrderItem.create(order: order, product: product, item_qty: 2) }

    it 'calculates the total price of all order items' do
      expect(order.sub_total).to eq(200)
    end
  end
end
