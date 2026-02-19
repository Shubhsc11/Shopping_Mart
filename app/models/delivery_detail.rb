# frozen_string_literal: true

class DeliveryDetail < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :orders, class_name: 'Order', dependent: :nullify

  validate :validate_delivery_details_limit, on: :create

  private

  def validate_delivery_details_limit
    if user.delivery_details.count >= 5
      errors.add(:base, "You can only have up to 5 delivery addresses.")
    end
  end
end
