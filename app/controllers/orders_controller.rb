class OrdersController < ApplicationController

	protect_from_forgery with: :exception

  before_action :current_cart
  
	def show
    @order = @current_order
  end

  def destroy
    @order = @current_order
    @order.destroy
    session[:order_id] = nil
    redirect_to root_path
  end


  private
    def current_order
      if session[:order_id]
        order = order.find_by(:id => session[:order_id])
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

end
