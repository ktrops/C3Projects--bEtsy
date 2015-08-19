Rails.application.routes.draw do
  root 'home#index'

  resources :users, except: [:new, :index, :destroy] do
    resources :products, except: [:index, :destroy]
    resources :orders, only: [:show]
  end

  get '/register', to: 'users#new', as: 'register'

  resources :products, except: [:destroy] do
    resources :reviews, only: [:new, :create]
    resources :order_items, only: [:create, :destroy]
    resources :product_categories, only: [:create, :destroy]
  end

  get     '/login',   to: 'sessions#new',     as: 'login'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy', as: 'logout'

  get '/products/merchant/filter', to: 'products#merchant', as: 'products_merchant'
  get '/products/category/filter', to: 'products#category', as: 'products_category'

  put '/products/:id/toggle_active', to: 'products#toggle_active', as: 'toggle_active'

  get '/users/:user_id/products', to: 'products#merchant_index', as: 'products_merchant_index'

  get '/users/:id/order_fulfillment',               to: 'orders#fulfillment',   as: 'order_fulfillment'
  put '/users/:id/order_fulfillment/mark_shipped',  to: 'orders#mark_shipped',  as: 'mark_shipped'
  get '/users/:id/order_fulfillment/status/filter', to: 'orders#filter_status', as: 'order_status'

  get '/cart', to: 'order_items#cart', as: 'cart'

  put 'orders/:id/finalize', to: 'orders#finalize', as: 'finalize_order'

  resources :order_items, only: [:update, :destroy]
  get '/checkout',     to: 'orders#checkout',     as: 'checkout'
  get '/confirmation', to: 'orders#confirmation', as: 'confirmation'
  post "/cancel",      to: "orders#cancel",       as: 'cancel_order'

  get '/category',  to: 'product_categories#new_category', as: 'new_category'
  post '/category', to: 'product_categories#create_category'
end
