class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum roles: {owner: "owner", customer: "customer"}

  has_many :products, :dependent => :destroy
  
  # after_initialize :set_default_role, :if => :new_record?

  # def set_default_role
  #   self.roles ||= 'customer'
  # end


end
