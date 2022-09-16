class Product < ApplicationRecord
	validates :p_name, presence: true, uniqueness: true
	validates :p_price, presence: true
	validates :p_qty, presence: true, numericality: { only_integer: true }

	belongs_to :user, class_name: 'User', foreign_key: :user_id
	belongs_to :category, class_name: 'Category', foreign_key: :category_id
	belongs_to :subcategory, class_name: 'Subcategory', foreign_key: :subcategory_id

	has_many :order_items, class_name: 'OrderItem', dependent: :destroy
end
	