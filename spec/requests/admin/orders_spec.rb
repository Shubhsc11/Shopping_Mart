# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin::Orders", type: :request do
  let(:admin_user) { create(:admin_user) }
  let!(:order) { create(:order) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/orders" do
    it "returns http success" do
      get "/admin/orders"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/orders/:id" do
    it "returns http success" do
      get "/admin/orders/#{order.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
