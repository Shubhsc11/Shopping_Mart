# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  # def show
  #   @user = User.find(params[:id])
  # end

  def new; end

  # def edit
  #   @user = User.find(params[:id])
  # end

  def create; end

  # def update
  #   @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     redirect_to users_path(@user)
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end

  def add_points
    authenticate_user!
    return unless current_user.customer?

    current_user.update(points: current_user.points + 100)
    redirect_to my_cart_path, notice: t('messages.users.points_added')
  end

  # private

  # def user_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, :roles)
  # end
end
