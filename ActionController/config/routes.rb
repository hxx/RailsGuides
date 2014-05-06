Rails.application.routes.draw do
  resources :clients

  # some helpers for resources route
  # clients_path            returns   /clients
  # new_client_path         returns   /clients/new
  # edit_client_path(:id)   returns   /client/:id/edit
  # client_path(:id)        returns   /clients/:id

  # Defining Multiple Resources at the Same Time
  resources :photos, :books, :videos

  # Singular Resources
  resources :geocoder
  # RailsGUides says this will create six different routes in your application
  # but I see that create seven different routes too through rake routes
  # It's has another route:
  # geocoder_index  GET    /geocoder(.:format)          geocoder#index

  # namespase
  namespace :admin do
    resources :posts, :comments
  end

  # scope module:
  scope module: 'admin' do
    resources :posts, :comments
  end

  # scope
  scope '/admin' do
    resources :posts, :comments
  end

  # a single case
  resources :ccc, path: '/admin/ccc'

  # Nested routes
  resources :magazines do
    resources :ads
  end

  # Resources should never be nested more than 1 level deep.

  # Shallow Nesting
  # resources :post do
  #   resources :comments, only: [:index, :new, :create]
  # end
  # resources :comments, only: [:show, :edit, :update, :destroy]
  resources :posts do
    resources :comments, shallow: true
  end

  # resources :posts, shallow: true do
  #   resources :comments
  #   resources :quotes
  #   resources :drafts
  # end
  shallow do
    resources :posts do
      resources :comments
      resources :quotes
      resources :drafts
    end
  end

  # scope shallow_path
  scope shallow_path: "sekret" do
    resources :posts do
      resources :comments, shallow: true
    end
  end

  # scope shallow_prefix
  scope shallow_prefix: "sekret" do
    resources :posts do
      resources :comments, shallow: true
    end
  end

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
