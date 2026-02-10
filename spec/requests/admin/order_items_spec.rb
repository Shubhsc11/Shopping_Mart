# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::OrderItems', type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:order) { create(:order) }
  let(:product) { create(:product) }
  let!(:order_item) { create(:order_item, order: order, product: product) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/order_items' do
    it 'returns http success' do
      get '/admin/order_items'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/order_items/:id' do
    it 'returns http success' do
      get "/admin/order_items/#{order_item.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
