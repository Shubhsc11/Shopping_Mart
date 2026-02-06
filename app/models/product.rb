# frozen_string_literal: true

class Product < ApplicationRecord
  validates :p_name, presence: true, uniqueness: true
  validates :p_price, presence: true
  validates :p_qty, presence: true, numericality: { only_integer: true }

  belongs_to :user, class_name: 'User'
  belongs_to :category, class_name: 'Category'
  belongs_to :subcategory, class_name: 'Subcategory'

  has_many :order_items, class_name: 'OrderItem', dependent: :destroy
  has_many :orders, through: :order_items, class_name: 'Order'
end
