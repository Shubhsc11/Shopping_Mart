# ActiveAdmin.register User do
#   permit_params do
#     permitted = [:email, :password, :password_confirmation, :roles]
#   end

#   filter :email
#   filter :roles
#   filter :created_at

#   index do
#     selectable_column
#     column "User_Id", :id
#     column "Email", :email
#     column "User_Role", :roles

#     actions
#   end

#   form do |f|
#     inputs 'Details' do
#       input :email
#       input :password
#       input :password_confirmation
#       input :roles
#     end
#     actions
#   end

# end
  

#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :roles
#   # See permitted parameters documentation:
#   #
#   # or
#   #
#   # permit_params do
#   #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :roles]
#   #   permitted << :other if params[:action] == 'create' && current_user.admin?
#   #   permitted
#   # end
  
