# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subcategories', type: :request do
  let(:category) { Category.create!(category_name: 'Test Category') }

  describe 'GET /index' do
    it 'returns http success' do
      get '/subcategories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      subcategory = Subcategory.create!(subcategory_name: 'Test Subcategory', category: category)
      get "/subcategories/#{subcategory.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
