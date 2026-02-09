# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin::AdminUsers", type: :request do
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe "GET /admin/admin_users" do
    it "returns http success" do
      get "/admin/admin_users"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/admin_users/new" do
    it "displays the form for creating a new AdminUser" do
      get "/admin/admin_users/new"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Email")
      expect(response.body).to include("Password")
    end
  end

  describe "GET /admin/admin_users/:id/edit" do
    it "displays the form for editing an AdminUser" do
      get "/admin/admin_users/#{admin_user.id}/edit"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Email")
    end
  end

  describe "POST /admin/admin_users" do
    let(:valid_params) do
      {
        admin_user: {
          email: "newadmin@example.com",
          password: "password#123",
          password_confirmation: "password#123"
        }
      }
    end

    it "creates a new AdminUser" do
      expect {
        post "/admin/admin_users", params: valid_params
      }.to change(AdminUser, :count).by(1)

      expect(response).to redirect_to(%r{/admin/admin_users/\d+})
    end
  end
end
