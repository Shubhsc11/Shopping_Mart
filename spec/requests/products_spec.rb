# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/products'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      # Need a user for product creation based on model specs
      user = User.create!(email: 'test_product@example.com', password: 'password', roles: 'customer')
      category = Category.create!(category_name: 'Test Category')
      subcategory = Subcategory.create!(subcategory_name: 'Test Subcategory', category: category)
      product = Product.create!(p_name: 'Test Product', p_price: 100, p_qty: 10, user: user, category: category,
                                subcategory: subcategory)
      get "/products/#{product.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
