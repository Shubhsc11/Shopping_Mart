# frozen_string_literal: true

class CartItemsController < ApplicationController
  def index
    redirect_to my_cart_path
  end

  def show
    redirect_to my_cart_path
  end

  def create
    product = Product.find_by(id: params[:product_id])
    cart_item = CartItem.find_by(cart_id: current_user.cart.id, product_id: product.id)

    begin
      ActiveRecord::Base.transaction do
        if cart_item.present?
          cart_item.update(item_qty: cart_item.item_qty + 1)
        else
          CartItem.create!(cart_id: current_user.cart.id, product_id: product.id, item_qty: 1)
        end
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = "Failed to add product to cart: #{e.message}"
    end

    path = params[:action_key] == 'buy' ? my_cart_path : products_path
    redirect_to path
  end

  def add_quantity
    @cart_item = CartItem.find(params[:id])
    @cart_item.item_qty += 1
    @cart_item.save
    redirect_to my_cart_path
  end

  def reduce_quantity
    @cart_item = CartItem.find(params[:id])
    @cart_item.item_qty -= 1 if @cart_item.item_qty > 1
    @cart_item.save
    redirect_to my_cart_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to my_cart_path, status: :see_other
  end
end
