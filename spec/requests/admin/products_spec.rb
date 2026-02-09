# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin::Products", type: :request do
  let(:admin_user) { create(:admin_user) }
  let(:category) { create(:category) }
  let(:subcategory) { create(:subcategory, category: category) }
  let!(:product) { create(:product, category: category, subcategory: subcategory) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/products" do
    it "returns http success" do
      get "/admin/products"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/products/:id" do
    it "returns http success" do
      get "/admin/products/#{product.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
