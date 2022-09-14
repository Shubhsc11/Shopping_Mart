class CreateSubcategories < ActiveRecord::Migration[7.0]
  def change
    create_table :subcategories do |t|
      t.string :subcategory_name
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
