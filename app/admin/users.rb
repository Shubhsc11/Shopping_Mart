# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params do
    %i[email password password_confirmation roles]
  end

  filter :email
  filter :roles
  filter :created_at

  index do
    selectable_column
    column 'User Id', :id
    column 'Email', :email
    column 'User Role', :roles

    actions
  end

  form do |_f|
    inputs 'Details' do
      input :email
      input :password
      input :password_confirmation
      input :roles
    end
    actions
  end
end
