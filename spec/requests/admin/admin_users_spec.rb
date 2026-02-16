# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::AdminUsers', type: :request do
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/admins' do
    it 'returns http success' do
      get '/admin/admins'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /admin/admins/new' do
    it 'displays the form for creating a new AdminUser' do
      get '/admin/admins/new'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Email')
      expect(response.body).to include('Password')
    end
  end

  describe 'GET /admin/admins/:id/edit' do
    it 'displays the form for editing an AdminUser' do
      get "/admin/admins/#{admin_user.id}/edit"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Email')
    end
  end

  describe 'POST /admin/admins' do
    let(:valid_params) do
      {
        admin_user: {
          email: 'newadmin@example.com',
          password: 'password#123',
          password_confirmation: 'password#123'
        }
      }
    end

    it 'creates a new AdminUser' do
      expect do
        post '/admin/admins', params: valid_params
      end.to change(AdminUser, :count).by(1)

      expect(response).to redirect_to(%r{/admin/admins/\d+})
    end
  end
end
