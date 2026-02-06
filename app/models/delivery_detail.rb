# frozen_string_literal: true

class DeliveryDetail < ApplicationRecord
  belongs_to :order, class_name: 'Order'
  belongs_to :user, class_name: 'User'
end
