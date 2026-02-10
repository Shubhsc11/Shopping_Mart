# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Dashboard', type: :request do
  let(:admin_user) { create(:admin_user) }

  before do
    sign_in admin_user
  end

  describe 'GET /admin/dashboard' do
    it 'returns http success' do
      get '/admin/dashboard'
      expect(response).to have_http_status(:success)
    end
  end
end
