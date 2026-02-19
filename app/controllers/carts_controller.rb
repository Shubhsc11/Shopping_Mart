# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product).order(created_at: :desc)
  end

  def destroy
    cart = current_user.cart
    cart_items = cart.cart_items
    cart_items.destroy_all
    redirect_to my_cart_path, status: :see_other
  end
end
