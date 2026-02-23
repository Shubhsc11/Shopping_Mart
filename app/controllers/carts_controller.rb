# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @cart = current_user.cart
    @cart_items = @cart.cart_items.includes(:product).order(created_at: :desc)
  end

  def destroy
    cart = current_user.cart
    product_ids = cart.cart_items.pluck(:product_id)

    if product_ids.any?
      current_user.orders.where(status: 'draft').joins(:order_items).where(order_items: { product_id: product_ids }).distinct.destroy_all
    end

    cart.cart_items.destroy_all

    redirect_to my_cart_path, status: :see_other
  end
end
