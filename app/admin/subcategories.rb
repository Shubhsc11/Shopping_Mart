# frozen_string_literal: true

ActiveAdmin.register Subcategory do
  menu parent: 'Catalog', priority: 2
  permit_params do
    %i[subcategory_name description category_id]
  end

  filter :id
  filter :subcategory_name, label: 'Name'
  filter :category_id, as: :select, collection: lambda {
    Category.all.map do |c|
      [c.category_name, c.id]
    end
  }, label: 'Category'
  filter :created_at

  index do
    selectable_column
    column :id
    column 'Name', :subcategory_name
    column :description do |s|
      truncate(s.description, length: 50).presence || '-'
    end
    column :category_id do |c|
      category = Category.find_by(id: c.category_id)
      category ? link_to(category.category_name, admin_category_path(category.id)) : '-'
    rescue StandardError
      nil
    end

    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :subcategory_name, label: 'Name'
      f.input :description
      f.input :category_id, as: :select, collection: Category.all.map { |a| [a.category_name, a.id] }
    end
    actions
  end
end
