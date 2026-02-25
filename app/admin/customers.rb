# frozen_string_literal: true

ActiveAdmin.register User, as: 'Customer' do
  menu parent: 'Users', priority: 2
  permit_params do
    %i[email password password_confirmation roles points]
  end

  filter :email
  filter :created_at

  index do
    selectable_column
    column 'Customer Id', :id do |user|
      link_to user.id, admin_customer_path(user)
    end
    column 'Email', :email
    column 'Points', :points do |user|
      user.points || 0
    end
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :email
      input :points
      input :password
      input :password_confirmation
    end
    actions
  end

  controller do
    def scoped_collection
      User.where(roles: 'customer')
    end
  end
end
