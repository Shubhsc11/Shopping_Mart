Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # get 'homes/index'
  devise_for :users

  root "products#index"
  resources :products
  resources :homes, only: :index do
    collection do
      get :countries_list
      get :cities_list
    end
  end
  resources :offers, only: [:index]
  resources :about_us, only: [:index]
  resources :contacts
  resources :categories
  resources :subcategories
  resources :orders
  resources :cart_items
  resources :carts, only: [:index, :destroy]
  resources :order_items
  resources :delivery_details
  resources :payments, only: :index do
    post :add_new_checkout
  end

  # JWT token endpoint
  post '/jwt_token', to: 'jwt_tokens#create'
  # Login endpoint (returns JWT)
  post '/login', to: 'jwt_tokens#create'

  post 'orders', to: "orders#create"

  post 'order_items/:id/add', to: "order_items#add_quantity", as: "order_item_add"
  post 'cart_items/:id/add', to: "cart_items#add_quantity", as: "cart_item_add"
  post 'cart_items/:id/reduce', to: "cart_items#reduce_quantity", as: "cart_item_reduce"
  post 'order_items/:id/reduce', to: "order_items#reduce_quantity", as: "order_item_reduce"
  post 'users/:id/add_point', to: "users#add_points", as: "user_add_points"
  get 'my_cart', to: 'carts#index'

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

end
