# frozen_string_literal: true

class DeliveryDetailsController < ApplicationController
  before_action :initiate_order, only: :index

  def index
    @delivery_details = current_user.delivery_details
  end

  def show
    @delivery_detail = DeliveryDetail.find(params[:id])
    @current_order = current_user.orders.last
    @available_points = current_user.points - @current_order.sub_total
  end

  def new
    @delivery_detail = DeliveryDetail.new
  end

  def edit
    @delivery_detail = DeliveryDetail.find(params[:id])
  end

  def create
    if current_user.delivery_details.count >= 5
      flash[:alert] = t('errors.delivery_details.limit_reached')
      redirect_to delivery_details_path and return
    end

    @delivery_detail = current_user.delivery_details.create(delivery_detail_params)
    if @delivery_detail.save
      redirect_to delivery_details_path, notice: t('messages.delivery_address.created')
    else
      redirect_to new_delivery_detail_path, status: :unprocessable_entity
    end
  end

  def update
    @delivery_detail = DeliveryDetail.find(params[:id])
    if @delivery_detail.update(update_delivery_detail_params)
      redirect_to delivery_details_path, notice: t('messages.delivery_address.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @delivery_detail = DeliveryDetail.find(params[:id])
    @delivery_detail.destroy
    redirect_to delivery_details_path, notice: t('messages.delivery_address.deleted'), status: :see_other
  end

  private

  def initiate_order
    cart = current_user.cart
    @current_order = Order.find_or_create_by(user_id: current_user.id, status: 'draft')
    cart.cart_items.each do |cart_item|
      product = cart_item.product
      order_item = @current_order.order_items.find_by(product_id: cart_item.product_id)
      if order_item.present?
        order_item.update(item_qty: cart_item.item_qty, item_price: cart_item.item_qty * product.p_price)
      else
        @current_order.order_items.create(
          product_id: cart_item.product_id, item_name: product.p_name,
          item_qty: cart_item.item_qty, item_price: cart_item.item_qty * product.p_price
        )
      end
    end
    @available_points = current_user.points - @current_order.sub_total
  end

  def update_delivery_detail_params
    params.require(:delivery_detail).permit(:full_name, :address, :contact_no)
  end

  def delivery_detail_params
    params.require(:delivery_detail).permit(:full_name, :address, :contact_no, :user_id)
  end
end
