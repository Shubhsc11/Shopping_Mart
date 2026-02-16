# frozen_string_literal: true

ActiveAdmin.register Category do
  menu parent: 'Catalog', priority: 1
  permit_params do
    %i[category_name description]
  end

  filter :id
  filter :category_name
  filter :created_at

  index do
    selectable_column
    column 'Id', :id
    column 'Name', :category_name
    column 'Description', :description do |c|
      truncate(c.description, length: 50).presence || '-'
    end

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
