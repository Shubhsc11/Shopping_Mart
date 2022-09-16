class ApplicationController < ActionController::Base
	# before_action :authenticate_user!, only: :index
	# protect_from_forgery
	before_action :configure_permitted_parameters, if: :devise_controller?

	# before_action :set_render_order
 #  before_action :initialize_order

 #  def set_render_order
 #    @render_order = true
 #  end

 #  def initialize_order
 #    @order ||= Order.find_by(id: session[:order_id])

 #    if @order.nil?
 #      @order = order.create
 #      session[:order_id] = @order.id
 #    end
 #  end



	protected
	# def after_sign_in_path_for(resource)
	# 	# users_path(resource)
	# 	products_path(resource)
	# end

	# def after_sign_out_path_for(resource)
	# 	homes_path(resource)
	# end

		def after_sign_up_path_for(resource)
			products_path(resource)
		end

		# def after_sign_in_path_for(resource)
		# 	stored_location_for(resource) ||
	 #    if resource.is_a?(Admin)
	 #      admin_dashboard_path
	 #    else
	 #      products_path(resource)
	 #    end
	 #  end

	  # def after_sign_out_path_for(resource)
	  # 	if resource.is_a?(Admin)
	  # 		new_admin_admin_user_path(resour
	  #   else
	  #     products_index_path(resource)
	  #   end
	  # end

		def configure_permitted_parameters
			devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :roles])
		end
end
