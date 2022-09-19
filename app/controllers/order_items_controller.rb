class OrderItemsController < ApplicationController

	def index
		@current_order = current_user.orders.last
		if @current_order.present?
	    @current_order.status = "placed"
	    @order_items = @current_order.order_items.order(created_at: :asc)
	  end
	end

	def show
		@order_item = OrderItem.find(params[:id])
	end

	def destroy
	  @order_item = OrderItem.find(params[:id])
	  @order_item.destroy
    redirect_to order_items_path
	end

	def add_quantity
	  @order_item = OrderItem.find(params[:id])
	  @order_item.item_qty += 1
	  @order_item.save
	  redirect_to order_items_path
	end

	def reduce_quantity
	  @order_item = OrderItem.find(params[:id])
	  if @order_item.item_qty > 1
	    @order_item.item_qty -= 1
	  end
	  @order_item.save
	  redirect_to order_items_path
	end

	# def add_points
	# 	$points += 100
	# 	redirect_to order_items_path
	# end  

	private
	  def order_item_params
	    params.require(:order_item).permit(:item_name, :item_price, :item_qty, :product_id, :order_id)
	  end
	  
end
