# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @order = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])
    @available_points = current_user.points
    current_user.cart.cart_items.destroy_all
  end

  def create
    @product = Product.find_by(id: params[:product_id])
    quantity = 1
    if current_user.orders.any?
      current_order = current_user.orders.last
      find_product = current_order.order_items.find_by(product_id: @product.id)
      if find_product.present?
        find_product.update(item_qty: quantity + 1)
      else
        current_order.order_items.create(product_id: @product.id, item_name: @product.p_name,
                                         item_qty: quantity, item_price: @product.p_price * quantity)
      end

      redirect_to root_path
    else
      @order = Order.create(user_id: current_user.id)
      if @order.save
        @order.order_items.create(product_id: @product.id, item_name: @product.p_name, item_qty: quantity,
                                  item_price: @product.p_price * quantity)
        redirect_to '/'
      else
        redirect_to new_order_path
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to root_path, status: :see_other
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(status: 'placed', delivery_detail_id: params[:delivery_detail_id])
      current_user.update(points: current_user.points - @order.sub_total)
      @order.order_items.each do |order_item|
        product = Product.find(order_item.product_id)
        product.update(p_qty: product.p_qty - order_item.item_qty)
      end
      redirect_to order_path(@order)
    else
      redirect_to root_path, alert: 'Failed to place order.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status)
  end
end
