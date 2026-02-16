# frozen_string_literal: true

ActiveAdmin.register User, as: 'Owner' do
  menu parent: 'Users', priority: 3
  permit_params do
    %i[email password password_confirmation roles]
  end

  filter :email
  filter :created_at

  index do
    selectable_column
    column 'Owner Id', :id do |user|
      link_to user.id, admin_owner_path(user)
    end
    column 'Email', :email
    actions
  end

  form do |_f|
    inputs 'Details' do
      input :email
      input :password
      input :password_confirmation
    end
    actions
  end

  controller do
    def scoped_collection
      User.where(roles: 'owner')
    end
  end
end
