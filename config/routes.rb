Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'homes/index'
  devise_for :users

  root "products#index"
  # resources :accounts
  resources :products
  resources :homes, only: [:index]
  resources :offers, only: [:index]
  resources :about_us, only: [:index]
  resources :contacts
  resources :categories
  resources :subcategories

  # resource :users do
  #   resources :products
  # end

  # <root>/users/:user_id/products/:id

  # get "/products/offers", to: "products#offers"

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

end
