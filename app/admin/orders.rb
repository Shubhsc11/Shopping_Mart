ActiveAdmin.register Order do

  actions :all, :except => [:new, :edit, :destroy]

  filter :id
  filter :user_id
  filter :status

  index do
    selectable_column
    column "Order Id", :id
    column :user_id do |u|
      user = User.find_by(id: u.user_id).email rescue nil
    end
    column "Order Status", :status
  end  
end
