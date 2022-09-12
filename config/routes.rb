Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'homes/index'
  devise_for :users

  root "products#index"
  # resources :accounts
  resources :homes, only: [:index]
  resources :products
  resources :offers, only: [:index]
  resources :about_us, only: [:index]
  resources :contact_us, only: [:index]

  # get "/products/offers", to: "products#offers"

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

end
