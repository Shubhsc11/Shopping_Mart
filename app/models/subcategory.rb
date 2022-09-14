class Subcategory < ApplicationRecord
  belongs_to :category, foreign_key: :category_id
  has_many :products
end
