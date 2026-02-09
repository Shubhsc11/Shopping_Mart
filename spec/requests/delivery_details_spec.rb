# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeliveryDetails', type: :request do
  let(:user) { User.create(email: 'test@example.com', password: 'password', roles: 'customer') }
  let(:order) { Order.create(user: user) }

  before do
    sign_in user
    # Ensure user has an order as the controller likely relies on it or we need to stub it
    # Controller uses `current_user.orders.last`, so creating one is sufficient
    order
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/delivery_details'
      expect(response).to have_http_status(:success)
    end
  end
end
