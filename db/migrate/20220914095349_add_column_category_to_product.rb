class AddColumnCategoryToProduct < ActiveRecord::Migration[7.0]
  def change
    # add_column :products, :category_name, :string
    add_column :products, :category_id, :integer
    add_column :products, :subcategory_id, :integer
  end
end
