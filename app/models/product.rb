class Product < ApplicationRecord
	validates :p_name, presence: true, uniqueness: true
	validates :p_price, presence: true
	validates :p_qty, presence: true, numericality: { only_integer: true }

	belongs_to :user, foreign_key: :user_id

	belongs_to :category, foreign_key: :category_id
	belongs_to :subcategory, foreign_key: :subcategory_id
end
	