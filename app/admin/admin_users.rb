# frozen_string_literal: true

ActiveAdmin.register AdminUser, as: 'Admins' do
  menu parent: 'Users', priority: 1
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :created_at do |admin_user|
      "#{time_ago_in_words(admin_user.created_at)} ago"
    end
    actions
  end

  filter :email
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
