# frozen_string_literal: true

class JwtTokensController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /jwt_token/login
  # params: { email: 'user@example.com', password: 'password' }
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      expiration = 24.hours.from_now
      token = jwt_encode(user_id: user.id, exp: expiration)

      render json: {
        token: token,
        expires_in: '24 hours',
        expires_at: expiration.iso8601,
        user: { id: user.id, email: user.email, role: user.roles }
      }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
