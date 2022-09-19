ActiveAdmin.register Product do
  
  actions :all, :except => [:new, :edit, :destroy]

  filter :user_id
  filter :p_name
  filter :p_price
  filter :p_qty
  filter :category_id
  filter :subcategory_id

  index do
    selectable_column
    column "Product Id", :id
    column "Product Name", :p_name
    column  "Product Price", :p_price
    column "Product Qty", :p_qty
    column :category_id do |c|
      category = Category.find_by(id: c.category_id).category_name rescue nil
    end
    column :subcategory_id do |s|
      sub_category = Subcategory.find_by(id: s.subcategory_id).subcategory_name rescue nil
    end
    column "User Id" do |u|
      user = User.find_by(id: u.user_id).email rescue nil
    end
    
    actions
  end
end