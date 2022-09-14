ActiveAdmin.register Category do

  permit_params do
    permitted = [:category_name, :description]
  end

  filter :id
  filter :category_name
  # filter :description
  filter :created_at

  index do
    selectable_column
    column "Category Id", :id
    column "Category Name", :category_name
    column  "Category Description", :description

    actions
  end

  form do |f|
    inputs 'Details' do
      input :category_name
      input :description
    end
    actions
  end
end



#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   # permit_params :category_name, :description
#   #
#   # or
#   #
#   # permit_params do
#   #   permitted = [:category_name, :description]
#   #   permitted << :other if params[:action] == 'create' && current_user.admin?
#   #   permitted
#   # end
  
# end
