# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params do
    %i[category_name description]
  end

  filter :id
  filter :category_name
  # filter :description
  filter :created_at

  index do
    selectable_column
    column 'Category Id', :id
    column 'Category Name', :category_name
    column 'Category Description', :description

    actions
  end

  form do |_f|
    inputs 'Details' do
      input :category_name
      input :description
    end
    actions
  end
end
