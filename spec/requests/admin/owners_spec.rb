# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Admin::Owners", type: :request do
  let(:admin_user) { create(:admin_user) }
  let!(:owner) { create(:user, roles: 'owner') }

  before do
    sign_in admin_user
  end

  describe "GET /admin/owners" do
    it "returns http success" do
      get "/admin/owners"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/owners/new" do
    it "displays the form for creating a new Owner" do
      get "/admin/owners/new"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Email")
      expect(response.body).to include("Password")
    end
  end

  describe "GET /admin/owners/:id" do
    it "returns http success" do
      get "/admin/owners/#{owner.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /admin/owners/:id/edit" do
    it "returns http success" do
      get "/admin/owners/#{owner.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /admin/owners" do
    let(:valid_params) do
      {
        user: {
          email: Faker::Internet.unique.email,
          password: "password#123",
          password_confirmation: "password#123",
          role: "owner"
        }
      }
    end

    it "creates a new Owner" do
      expect {
        post "/admin/owners", params: valid_params
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(%r{/admin/owners/\d+})
    end
  end

  describe "PUT /admin/owners/:id" do
    let(:valid_params) do
      {
        user: {
          email: Faker::Internet.unique.email,
          password: "password#123",
          password_confirmation: "password#123",
          role: "owner"
        }
      }
    end

    it "updates an Owner" do
      put "/admin/owners/#{owner.id}", params: valid_params
      expect(response).to redirect_to(%r{/admin/owners/\d+})
    end
  end

  describe "DELETE /admin/owners/:id" do
    it "deletes an Owner" do
      expect {
        delete "/admin/owners/#{owner.id}"
      }.to change(User, :count).by(-1)

      expect(response).to redirect_to("/admin/owners")
    end
  end
end
