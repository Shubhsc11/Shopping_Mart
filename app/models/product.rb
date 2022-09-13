class Product < ApplicationRecord
	validates :p_name, presence: true, uniqueness: {message: "has already been taken" }
	validates :p_price, presence: true
	validates :p_qty, presence: true, numericality: { only_integer: true }

	belongs_to :user, foreign_key: :user_id
end
