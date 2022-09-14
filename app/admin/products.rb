ActiveAdmin.register Product do
  actions :all, :except => [:new, :edit, :destroy]

  # permit_params do
  #   permitted = [:p_name, :p_price, :p_qty, :category_id, :subcategory_id, :user_id]
  # end

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

  # form do |f|
  #   inputs 'Details' do
  #     input :user_id, as: :hidden, valur: ''
  #     input :p_name
  #     input :p_price
  #     input :p_qty
  #     f.input :category_id, :as => :select, collection: Category.all.map { |a| [a.category_name, a.id] }
  #   end
  #   actions
  # end
# end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :p_name, :p_price, :p_qty, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:p_name, :p_price, :p_qty, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end