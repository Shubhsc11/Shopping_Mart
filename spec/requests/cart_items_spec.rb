# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartItems', type: :request do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }

  before do
    sign_in user
  end

  describe 'GET /cart_items' do
    it 'redirects to my_cart_path' do
      get '/cart_items'
      expect(response).to redirect_to('/my_cart')
    end
  end
end
