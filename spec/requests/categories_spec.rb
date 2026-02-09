# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :request do
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/categories', headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      category = Category.create!(category_name: 'Test Category')
      get "/categories/#{category.id}", headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end
end
