class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

		# def after_sign_up_path_for(resource)
		# 	products_path(resource)
		# end

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
