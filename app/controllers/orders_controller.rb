class OrdersController < ApplicationController

  def index
    @order = Order.all
  end

  # def new
  #   @product = Product.find_by(params[:id])
  #   @order = Order.new
  # end

  def show
    @order = Order.find_by(id: params[:id])
  end

  def create
    @product = Product.find_by(id: params[:product_id])
    quantity = 1
    if current_user.orders.any?
      current_order = current_user.orders.last
      find_product = current_order.order_items.find_by_product_id(@product.id)
      if find_product.present?
        order_item = find_product.update(item_qty: quantity+1)
      else
        order_item = current_order.order_items.create(product_id: @product.id, item_name: @product.p_name, item_qty: quantity, item_price: @product.p_price * quantity)
      end
      
      redirect_to root_path

    else
      @order = Order.create(user_id: current_user.id)
      if @order.save
        order_item = @order.order_items.create(product_id: @product.id, item_name: @product.p_name, item_qty: quantity, item_price: @product.p_price * quantity)
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

  private
    def order_params
      params.require(:order).permit(:user_id, :status)
    end

end
