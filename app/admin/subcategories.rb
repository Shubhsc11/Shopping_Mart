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
    column :category_id do |c|
      category = Category.find_by(id: c.category_id).category_name rescue nil
    end

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