# frozen_string_literal: true

ActiveAdmin.register User, as: 'Owner' do
  permit_params do
    %i[email password password_confirmation roles]
  end

  filter :email
  filter :created_at

  index do
    selectable_column
    column 'User Id', :id
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
