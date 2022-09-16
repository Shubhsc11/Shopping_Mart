class Subcategory < ApplicationRecord
  belongs_to :category, class_name: 'Category', foreign_key: :category_id
  has_many :products, class_name: 'Product', dependent: :destroy
  validates_associated :products
end
