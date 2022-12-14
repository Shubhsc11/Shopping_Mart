ActiveAdmin.register User, :as => 'Customer' do
  permit_params do
    permitted = [:email, :password, :password_confirmation, :roles]
  end

  filter :email
  filter :created_at

  index do
    selectable_column
    column "User_Id", :id
    column "Email", :email
    column "Points", :points
    actions
  end

  form do |f|
    inputs 'Details' do
      input :email
      input :password
      input :password_confirmation
      # input :roles
    end
    actions
  end

  controller do
    def scoped_collection
      User.where(roles: "customer")
    end
  end

end
  
  