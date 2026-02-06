# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homes', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/homes'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /countries_list' do
    it 'returns a list of countries including Gulf countries' do
      get '/homes/countries_list'
      expect(response).to have_http_status(:success)
      json_response = response.parsed_body
      expect(json_response).to have_key('countries')
      expect(json_response['countries']).to be_an(Array)

      # Verify Gulf countries are present (checking first one as example SA)
      gulf_country_codes = %w[SA KW AE QA BH OM IQ]
      countries = json_response['countries']
      gulf_country_codes.each do |code|
        expect(countries.any? { |c| c['short_name'] == code }).to be_truthy
      end
    end
  end

  describe 'GET /cities_list' do
    it 'returns a list of cities for India' do
      get '/homes/cities_list'
      expect(response).to have_http_status(:success)
      json_response = response.parsed_body
      expect(json_response).to have_key('cities')
      expect(json_response['cities']).to be_an(Array)
      # Sanity check that we got some cities
      expect(json_response['cities']).not_to be_empty
    end
  end
end
