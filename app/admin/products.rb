# frozen_string_literal: true

ActiveAdmin.register Product do
  actions :all, except: %i[new edit destroy]

  filter :user_id
  filter :p_name
  filter :p_price
  filter :p_qty
  filter :category_id
  filter :subcategory_id

  index do
    selectable_column
    column 'Product Id', :id
    column 'Product Name', :p_name
    column 'Product Price', :p_price
    column 'Product Qty', :p_qty
    column :category_id do |c|
      Category.find_by(id: c.category_id).category_name
    end
    column :subcategory_id do |s|
      Subcategory.find_by(id: s.subcategory_id).subcategory_name
    end
    column 'User Id' do |u|
      User.find_by(id: u.user_id).email
    end

    actions
  end
end
