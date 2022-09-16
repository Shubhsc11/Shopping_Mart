class Category < ApplicationRecord
	has_many :products, class_name: 'Product', dependent: :destroy
	has_many :subcategories, class_name: 'Subcategory', dependent: :destroy
	validates_associated :products
	validates_associated :subcategories
end
