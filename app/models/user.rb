class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum roles: {owner: "owner", customer: "customer"}

  has_many :products, class_name: 'Product', dependent: :destroy
  has_many :orders, class_name: 'Order', dependent: :destroy
  has_many :delivery_details, class_name: 'DeliveryDetail', dependent: :destroy

  after_create :set_credit_points 

  def set_credit_points
    if self.customer?
      self.update(points: 5000)
    end
  end

end
