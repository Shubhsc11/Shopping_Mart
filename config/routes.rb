Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'homes/index'
  devise_for :users

  # get 'order', to: 'order#show'
  # post 'order/add'
  # post 'order/remove'

  root "products#index"
  # resources :accounts
  resources :products
  resources :homes, only: [:index]
  resources :offers, only: [:index]
  resources :about_us, only: [:index]
  resources :contacts
  resources :categories
  resources :subcategories
  resources :orders
  resources :order_items

  post 'orders', to: "orders#create"

  # get 'order_items/:id' => "order_items#show"
  # delete 'order_items/:id' => "order_items#destroy"

  # post 'order_items/:id/add' => "order_items#add_quantity", as: "order_item_add"
  # post 'order_items/:id/reduce' => "order_items#reduce_quantity", as: "order_item_reduce"


  # resource :users do
  #   resources :products
  # end

  # <root>/users/:user_id/products/:id

  # get "/products/offers", to: "products#offers"

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

end
