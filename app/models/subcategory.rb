# frozen_string_literal: true

class Subcategory < ApplicationRecord
  belongs_to :category, class_name: 'Category'
  has_many :products, class_name: 'Product', dependent: :destroy
  validates_associated :products
  validates :subcategory_name, presence: true, uniqueness: true
end
