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
    @order = find_order
    return redirect_to orders_path, alert: t('messages.order.not_found') if @order.nil?

    if current_user.owner?
      update_order_status
    else
      process_order_placement
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

  def find_order
    if current_user.owner?
      Order.joins(:products).where(products: { user_id: current_user.id }, id: params[:id]).distinct.first
    else
      current_user.orders.find_by(id: params[:id])
    end
  end

  def update_order_status
    if @order.update(status: params[:order][:status])
      redirect_to order_path(@order), notice: t('messages.order.status_updated')
    else
      redirect_to order_path(@order), alert: t('messages.order.status_update_failed')
    end
  end

  def process_order_placement
    @order.place!(params[:delivery_detail_id])
    current_user.cart&.cart_items&.destroy_all
    redirect_to order_path(@order), notice: t('messages.order.place_success')
  rescue ActiveRecord::RecordInvalid => e
    redirect_to order_path(@order), alert: "#{t('messages.order.place_failure')}: #{e.message}"
  rescue StandardError
    redirect_to root_path, alert: t('messages.order.place_failure')
  end

  def order_params
    params.require(:order).permit(:user_id, :status)
  end
end
