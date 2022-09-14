ActiveAdmin.register Subcategory do

  permit_params do
    permitted = [:subcategory_name, :description, :category_id]
  end

  filter :id
  filter :subcategory_name
  filter :category_id
  filter :created_at

  index do
    selectable_column
    column :id
    column :subcategory_name
    column :description
    column :category_id

    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :subcategory_name
      f.input :description
      f.input :category_id, :as => :select, collection: Category.all.map { |a| [a.category_name, a.id] }
    end
    actions
  end

end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :subcategory_name, :description, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:subcategory_name, :description, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
# end
