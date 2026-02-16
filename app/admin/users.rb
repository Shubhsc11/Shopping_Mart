# frozen_string_literal: true

ActiveAdmin.register User do
  # menu priority: 2
  permit_params do
    %i[email password password_confirmation roles]
  end

  filter :email
  filter :roles
  filter :created_at

  index do
    selectable_column
    column 'User Id', :id do |user|
      link_to user.id, admin_user_path(user)
    end
    column 'Email', :email
    column 'User Role', :roles do |user|
      user.roles.humanize
    end

    actions
  end

  form do |_f|
    inputs 'Details' do
      input :email
      input :password
      input :password_confirmation
      input :roles, as: :select, collection: User.roles.keys.map { |role| [role.humanize, role] }
    end
    actions
  end
end
