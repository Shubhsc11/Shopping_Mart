# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = if current_user.owner?
                Order.joins(:products).where(products: { user_id: current_user.id }).distinct.order(created_at: :desc)
              else
                current_user.orders.order(created_at: :desc)
              end
  end

  def show
    @order = if current_user.owner?
               Order.joins(:products).where(products: { user_id: current_user.id }, id: params[:id]).distinct.first
             else
               current_user.orders.find_by(id: params[:id])
             end

    if @order.nil?
      redirect_to orders_path, alert: t('messages.order.not_found')
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

  def update
    @order = current_user.orders.find(params[:id])
    if @order.update(status: 'placed', delivery_detail_id: params[:delivery_detail_id])
      begin
        current_user.update(points: current_user.points - @order.sub_total)
      rescue ActiveRecord::RecordInvalid => e
        @order.update(status: 'draft')
        redirect_to order_path(@order), alert: t('messages.order.place_failure') + ": #{e.message}"
        return
      end

      @order.order_items.each do |order_item|
        product = Product.find(order_item.product_id)
        product.update(p_qty: product.p_qty - order_item.item_qty)
      end
      # Clear cart only after successful placement
      current_user.cart&.cart_items&.destroy_all
      redirect_to order_path(@order), notice: t('messages.order.place_success')
    else
      redirect_to root_path, alert: t('messages.order.place_failure')
    end
  end

  def destroy
    @order = current_user.orders.find_by(id: params[:id])

    if @order.nil?
      redirect_to orders_path, alert: t('messages.order.not_found')
    elsif @order.refundable?
      redirect_to orders_path, alert: t('messages.order.cancel_failure')
    else
      @order.placed? || @order.confirmed? ? @order.cancel! : @order.destroy
      redirect_to orders_path, notice: t('messages.order.cancel_success')
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to orders_path, alert: "#{t('messages.order.cancel_failure')}: #{e.message}"
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :status)
  end
end
