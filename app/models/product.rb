class Product < ApplicationRecord
	validates :p_name, presence: true
	validates :p_price, presence: true
	validates :p_qty, presence: true, numericality: { only_integer: true }
end
