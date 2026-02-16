# frozen_string_literal: true

ActiveAdmin.register Order do
  menu parent: 'Order Details', priority: 1
  actions :all, except: %i[new edit destroy]

  filter :id
  filter :user_id
  filter :status

  index do
    selectable_column
    column 'Order Id', :id
    column :user_id do |u|
      User.find_by(id: u.user_id).email
    rescue StandardError
      nil
    end
    column 'Order Status', :status do |order|
      order.status.humanize.presence || '-'
    end
  end
end
