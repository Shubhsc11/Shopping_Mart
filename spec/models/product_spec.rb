# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:p_name) }
    # it { should validate_uniqueness_of(:p_name) } # Requires a record to verify uniqueness
    it { should validate_presence_of(:p_price) }
    it { should validate_presence_of(:p_qty) }
    it { should validate_numericality_of(:p_qty).only_integer }
  end

  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:category).class_name('Category') }
    it { should belong_to(:subcategory).class_name('Subcategory') }
    it { should have_many(:order_items).class_name('OrderItem').dependent(:destroy) }
    it { should have_many(:orders).through(:order_items).class_name('Order') }
  end
end
