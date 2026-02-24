# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :roles, { owner: 'owner', customer: 'customer' }

  has_many :products, class_name: 'Product', dependent: :destroy
  has_many :orders, class_name: 'Order', dependent: :destroy
  has_many :delivery_details, class_name: 'DeliveryDetail', dependent: :destroy
  has_one :cart, class_name: 'Cart', dependent: :destroy

  validates :roles, presence: true

  after_create :set_credit_points, :set_default_role, :add_cart
  around_update :check_credit_points

  def set_credit_points
    return unless customer?

    update(points: 5000)
  end

  def set_default_role
    update(roles: 'customer') if roles.blank?
  end

  def add_cart
    Cart.create(user_id: id)
  end

  def check_credit_points
    return unless customer?

    if points.negative?
      errors.add(:points, "You don't have enough credit points to place this order.")
    else
      yield
    end
  end
end
