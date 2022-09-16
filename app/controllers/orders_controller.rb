class OrdersController < ApplicationController

  # protect_from_forgery with: :exception
  # after_action :current_order, only: :create
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
    # @product = current_user.order.build(order_params)

    quantity = 1

    @user = current_user
    # @user = User.find_by(params[:user_id])
    @order = Order.create(user_id: current_user.id)
    
    if @order.save
      order_item = @order.order_items.create(product_id: @product.id, item_name: @product.p_name, item_qty: quantity, item_price: @product.p_price * quantity)
      redirect_to '/'
    else
      redirect_to new_order_path
    end 
    


    # user.update(current_order: order.id )
    # order_item = order.order_item
  end
  

  def destroy
    @order = Order.find_by(params[:id])
    @order.destroy
    session[:order_id] = nil
    redirect_to root_path
  end


  private
    def current_order
      if session[:order_id]
        order = Order.find_by(:id => session[:order_id])
        if order.present?
          @current_order = order
        else
          session[:order_id] = nil
        end
      end

      if session[:order_id] == nil
        @current_order = order.create
        session[:order_id] = @current_order.id
      end
    end


    def order_params
      params.require(:order).permit(:user_id, :status)
    end

end
