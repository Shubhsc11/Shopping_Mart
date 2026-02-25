# frozen_string_literal: true

ActiveAdmin.register Product do
  filter :user_id, as: :select, collection: lambda {
    User.all.map do |u|
      [u.email, u.id]
    end
  }, label: 'User'
  filter :p_name, label: 'Product Name'
  filter :p_price, label: 'Product Price'
  filter :p_qty, label: 'Product Quantity'
  filter :category_id, as: :select, collection: lambda {
    Category.all.map do |c|
      [c.category_name, c.id]
    end
  }, label: 'Category'
  filter :subcategory_id, as: :select, collection: lambda {
    Subcategory.all.map do |s|
      [s.subcategory_name, s.id]
    end
  }, label: 'Subcategory'

  index do
    selectable_column
    column 'Id', :id
    column 'Name', :p_name
    column 'Price', :p_price
    column 'Quantity', :p_qty
    column :category_id do |product|
      category = Category.find_by(id: product.category_id)
      category ? link_to(category.category_name, admin_category_path(category.id)) : '-'
    end
    column :subcategory_id do |product|
      subcategory = Subcategory.find_by(id: product.subcategory_id)
      subcategory ? link_to(subcategory.subcategory_name, admin_subcategory_path(subcategory.id)) : '-'
    end
    column 'User Id' do |product|
      user = User.find_by(id: product.user_id)
      user ? link_to(user.email, admin_user_path(user.id)) : '-'
    end

    actions
  end

  form do |_f|
    inputs 'Details' do
      input :p_name, label: 'Product Name'
      input :p_price, label: 'Product Price'
      input :p_qty, label: 'Product Quantity'
      input :category_id, as: :select, collection: Category.all.map { |c| [c.category_name, c.id] }, label: 'Category'
      input :subcategory_id, as: :select, collection: Subcategory.all.map { |s| [s.subcategory_name, s.id] }, label: 'Subcategory'
      input :user_id, as: :select, collection: User.owner.map { |u| [u.email, u.id] }, label: 'User'
    end
    actions
  end
end
