Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'homes/index'
  devise_for :users

  root "homes#index"
  # resources :accounts
  resources :homes
  resources :products


  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

end
