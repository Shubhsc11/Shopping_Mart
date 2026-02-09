# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin::Customers", type: :request do
  let(:admin_user) { create(:admin_user) }
  let!(:customer) { create(:user, roles: 'customer') }

  before do
    sign_in admin_user
  end

  describe "GET /admin/customers" do
    it "returns http success" do
      get "/admin/customers"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/customers/new" do
    it "displays the form for creating a new Customer" do
      get "/admin/customers/new"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Email")
      expect(response.body).to include("Password")
    end
  end

  describe "GET /admin/customers/:id" do
    it "returns http success" do
      get "/admin/customers/#{customer.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/customers/:id/edit" do
    it "returns http success" do
      get "/admin/customers/#{customer.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /admin/customers" do
    let(:valid_params) do
      {
        user: {
          email: Faker::Internet.unique.email,
          password: "password#123",
          password_confirmation: "password#123",
          role: "customer"
        }
      }
    end

    it "creates a new Customer" do
      expect {
        post "/admin/customers", params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(%r{/admin/customers/\d+})
    end
  end

  describe "PUT /admin/customers/:id" do
    let(:valid_params) do
      {
        user: {
          email: Faker::Internet.unique.email,
          password: "password#123",
          password_confirmation: "password#123",
          role: "customer"
        }
      }
    end

    it "updates an Customer" do
      put "/admin/customers/#{customer.id}", params: valid_params
      expect(response).to redirect_to(%r{/admin/customers/\d+})
    end
  end

  describe "DELETE /admin/customers/:id" do
    it "deletes an Customer" do
      expect {
        delete "/admin/customers/#{customer.id}"
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to("/admin/customers")
    end
  end
end
