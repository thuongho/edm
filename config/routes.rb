Rails.application.routes.draw do

  
  devise_for :users
  resources :listings do
    resources :orders, only: [:new, :create]
  end

  get 'pages/about'

  get 'pages/contact'


  root 'listings#index'

  match '/seller', to: 'listings#seller', via: 'get'
  match '/sales', to: 'orders#sales', via: 'get'
  match '/purchases', to: 'orders#purchases', via: 'get'
  # match '/show_cart', to: 'listings#show_cart', via: 'get'
  # match '/add_to_cart', to: 'listings#add_to_cart', via: 'post'
  # match '/add', to: 'cart#add', via: 'get'
  match '/cart', to: 'carts#index', via: 'get'

  match ':controller(/:action(/:id))', :via => [:get, :post]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
