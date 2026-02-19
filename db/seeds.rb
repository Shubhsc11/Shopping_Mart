# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
admin = AdminUser.find_or_create_by(email: 'admin@example.com') do |admin_user|
  admin_user.password = 'password'
  admin_user.password_confirmation = 'password'
end

owner= User.find_or_create_by(email: 'owner@example.com', roles: 'owner') do |user|
  user.password = 'Password@321'
  user.password_confirmation = 'Password@321'
end

customer = User.find_or_create_by(email: 'customer@example.com', roles: 'customer') do |user|
  user.password = 'Password@321'
  user.password_confirmation = 'Password@321'
end

User.all.each do |user|
  Cart.find_or_create_by(user_id: user.id)
end

puts 'Seed data created/updated successfully!'
