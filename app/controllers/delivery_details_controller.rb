class DeliveryDetailsController < ApplicationController

	before_action :find_current_order, only: %i[index new create edit update show destroy_current_order]
	before_action :update_points, only: :index

	def index
	end

	def show
    @delivery_detail = DeliveryDetail.find(params[:id])
  end

	def new
		@delivery_detail = DeliveryDetail.new
	end

	def create
		@delivery_detail = current_user.delivery_details.create(delivery_detail_params)
		if @delivery_detail.save
			# @current_order.destroy
			redirect_to @delivery_detail
		else
			redirect_to new_delivery_detail_path
		end
	end

	def edit
    @delivery_detail = DeliveryDetail.find(params[:id])
  end

  def update
    @delivery_detail = DeliveryDetail.find(params[:id])
    if @delivery_detail.update(update_delivery_detail_params)
      redirect_to @delivery_detail
    else
      render :edit, status: :unprocessable_entity
    end
  end


	private

		def update_points
			available_points = current_user.points - @current_order.sub_total
			current_user.update(points: available_points)
			byebug
		end

		def update_delivery_detail_params
			params.require(:delivery_detail).permit(:full_name, :address, :contact_no)
		end

		def delivery_detail_params
      params.require(:delivery_detail).permit(:full_name, :address, :contact_no, :order_id, :user_id)
    end

		def find_current_order
			@current_order = current_user.orders.last
			@current_order.status = 'confirmed'
		end

end
