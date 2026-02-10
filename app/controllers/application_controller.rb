# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user

  protected

  # def after_sign_up_path_for(resource)
  # 	products_path(resource)
  # end

  # def after_sign_in_path_for(resource)
  # 	stored_location_for(resource) ||
  #    if resource.is_a?(Admin)
  #      admin_dashboard_path
  #    else
  #      products_path(resource)
  #    end
  #  end

  # def after_sign_out_path_for(resource)
  # 	if resource.is_a?(Admin)
  # 		new_admin_admin_user_path(resour
  #   else
  #     products_index_path(resource)
  #   end
  # end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password password_confirmation roles])
  end

  private

  def jwt_secret
    Rails.application.credentials.dig(:jwt_secret) || Rails.application.secret_key_base
  end

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, jwt_secret)
  end

  def jwt_decode(token)
    return nil unless token
    body = JWT.decode(token, jwt_secret)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  # Authenticate request using Authorization: Bearer <token>
  def authenticate_request!
    return if devise_signed_in?

    token = request.headers['Authorization']&.split(' ')&.last
    decoded = jwt_decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end

  # Prefer Devise's current_user when available, otherwise fall back to JWT
  def current_user
    # If Devise defines a current_user, prefer it
    begin
      du = super
      return du if du.present?
    rescue NoMethodError
      # no Devise current_user available
    end

    return @current_user if defined?(@current_user) && @current_user

    token = request.headers['Authorization']&.split(' ')&.last
    decoded = jwt_decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded
  end
end
