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
  
