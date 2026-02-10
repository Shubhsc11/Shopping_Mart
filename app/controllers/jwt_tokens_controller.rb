# frozen_string_literal: true

class JwtTokensController < ApplicationController
  skip_before_action :verify_authenticity_token

  # POST /jwt_token
  # params: { email: '...', password: '...' }
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { token: token }, status: :created
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
