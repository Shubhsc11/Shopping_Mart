# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    if current_user.owner?
      @orders = Order.joins(:products).where(products: { user_id: current_user.id }).distinct.order(created_at: :desc)
    else
      @orders = current_user.orders.order(created_at: :desc)
    end
  end

  def show
    if current_user.owner?
      @order = Order.joins(:products).where(products: { user_id: current_user.id }, id: params[:id]).distinct.first
    else
      @order = current_user.orders.find_by(id: params[:id])
    end

    if @order.nil?
      redirect_to orders_path, alert: "Order not found."
      return
    end
    @available_points = current_user.points
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
      @order = current_user.orders.create
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
    @order = current_user.orders.find_by(id: params[:id])
    
    if @order.nil?
      redirect_to orders_path, alert: "Order not found or you don't have permission to cancel it."
      return
    end

    if @order.shipped? || @order.delivered?
      redirect_to orders_path, alert: "Cannot cancel order that has already been #{@order.status}."
      return
    end

    # Handle refunds and quantity restoration for placed/confirmed orders
    if @order.placed? || @order.confirmed?
      ActiveRecord::Base.transaction do
        # Refund points
        @order.user.update!(points: @order.user.points + @order.sub_total)
        
        # Restore quantities
        @order.order_items.each do |item|
          item.product.update!(p_qty: item.product.p_qty + item.item_qty)
        end
        
        @order.update(status: 'cancelled')
      end
      redirect_to orders_path, notice: "Order cancelled. Points refunded and inventory restored."
    else
      # Draft orders can just be deleted
      @order.destroy
      redirect_to orders_path, notice: "Order deleted."
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to orders_path, alert: "Failed to cancel order: #{e.message}"
  end

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(status: 'placed', delivery_detail_id: params[:delivery_detail_id])
      current_user.update(points: current_user.points - @order.sub_total)
      @order.order_items.each do |order_item|
        product = Product.find(order_item.product_id)
        product.update(p_qty: product.p_qty - order_item.item_qty)
      end
      # Clear cart only after successful placement
      current_user.cart&.cart_items&.destroy_all
      redirect_to order_path(@order), notice: "Order placed successfully!"
    else
      redirect_to root_path, alert: 'Failed to place order.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status)
  end
end
