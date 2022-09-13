class ContactUs < ApplicationRecord
	# self.table_name = "contact"
	# self.table_name = "my_products"
	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
end
