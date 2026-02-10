# frozen_string_literal: true

class LoginsController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /login
  # params: { email: 'user@example.com', password: 'password' }
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { token: token, exp: 24.hours.from_now.to_i, user: { id: user.id, email: user.email } }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
