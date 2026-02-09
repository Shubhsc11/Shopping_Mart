# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderItems', type: :request do
  let(:user) { User.create(email: 'test_order_items@example.com', password: 'password', roles: 'customer') }
  let(:order) { Order.create(user: user) }

  before do
    sign_in user
    order
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/order_items'
      expect(response).to have_http_status(:success)
    end
  end
end
