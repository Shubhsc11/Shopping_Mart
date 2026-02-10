# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subcategories', type: :request do
  let(:category) { create(:category) }

  describe 'GET /index' do
    it 'returns http success' do
      get '/subcategories'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      subcategory = create(:subcategory, category: category)
      get "/subcategories/#{subcategory.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
