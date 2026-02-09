# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/contacts'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Contact' do
        expect do
          post '/contacts',
               params: { contact: { first_name: 'John', last_name: 'Doe', email: 'john@example.com',
                                    message: 'Hello' } }
        end.to change(Contact, :count).by(1)
        expect(response).to have_http_status(:found) # Redirects to show
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Contact' do
        expect do
          post '/contacts', params: { contact: { first_name: '', email: 'invalid' } }
        end.to change(Contact, :count).by(0)
        expect(response).to have_http_status(:found) # Redirects to new
      end
    end
  end
end
