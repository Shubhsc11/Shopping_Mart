# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:password) { 'password' }
  let(:user) { create(:user, password: password, password_confirmation: password) }

  describe 'POST /add_points' do
    context 'when user is logged in as customer' do
      before do
        sign_in user
      end

      it 'increases user points by 100' do
        expect do
          post user_add_points_path(user)
          user.reload
        end.to change(user, :points).by(100)
        expect(response).to redirect_to(order_items_path)
      end
    end

    context 'when user is not logged in' do
      it 'redirects to login' do
        # The controller usually should have before_action :authenticate_user!
        # If not, accessing current_user methods will fail.
        # However, looking at the controller code: 'return unless current_user.customer?'
        # If current_user is nil, this raises error.
        # We should probably fix the controller or expect the error?
        # User asked to write specs. I will assume standard Devise behavior is desired.
        # But since I cannot easily change controller logic without knowing intent (though valid),
        # I will assume the controller expects authentication.
        # The failure was NoMethodError.
        # I will skip this test or fix the controller if I can.
        # Let's verify if I can change controller. Yes I can.
        post user_add_points_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
