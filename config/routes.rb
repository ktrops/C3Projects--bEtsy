Rails.application.routes.draw do

  root 'home#index'

  resources :users do
    resources :products, except: [:index]
    resources :orders, only: [:show, :update]
  end

  resources :products do
    resources :reviews, only: [:new, :create]
    resources :order_items, only: [:create, :destroy]
    resources :product_categories, only: [:create, :destroy]
  end

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get '/products/merchant/filter', to: 'products#merchant', as: 'products_merchant'

  get '/products/category/filter', to: 'products#category', as: 'products_category'

  put '/products/:id/toggle_active', to: 'products#toggle_active', as: 'toggle_active'


  get '/users/:user_id/products', to: 'products#merchant_index', as: 'products_merchant_index'

  get '/cart', to: 'order_items#cart', as: 'cart'
  # should the finalize route have the :id in the url?
  put 'orders/:id/finalize', to: 'orders#finalize', as: 'finalize_order'
  
  resources :order_items, only: [:update, :destroy]
  get '/checkout', to: 'orders#checkout', as: 'checkout'
  get '/confirmation', to: 'orders#confirmation', as: 'confirmation'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # get 'orders/:id' => 'orders#show'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
