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

  # routing concerns
  concern :commentable do
    resources :comments
  end
  resources :messages, concerns: :commentable

  concern :image_attachable do
    resources :images, only: :index
  end
  resources :posts, concerns: [:commentable, :image_attachable]

  namespace :posts do
    concerns :commentable
  end


  # Adding Member Routes
  resources :photos do
    member do
      get 'preview'
    end
  end
  # resources :photos do
  #   get 'preview', on: :member
  # end

  # Adding Collection Routes
  resources :photos do
    collection do
      get 'search'
    end
  end
  # resources :photos do
  #   get 'search', on: :collection
  # end

  # Adding Routes for Additional New Actions
  resources :comments do
    get 'preview', on: :new
  end


  # Some Non-Resourceful Routes
  # Bound Parameters
  get ':controller(/:action(/:id))'

  # Dynamic Segments
  get ':controller/:action/:id/:user_id'

  # Static Segments
  get ':controller/:action/:id/with_user/:user_id'

  # Defining Defaults
  get 'photos/:id', to: 'photos#show'

  # Naming Routes
  get 'exit', to: 'sessions#destroy', as: :logout
  get ':username', to: 'users#show', as: :user

  # Segment Constraints
  get '/:id', to: 'posts#show', constraints: { id: /\d.+/ }
  get '/:username', to: 'users#show'

  # Request-Based Constraints
  namespace :admin do
    constraints subdomain: 'admin' do
      resources :photos
    end
  end

  # Some Redirection
  get '/stories', to: redirect('/posts')
  get '/stories/:name', to: redirect('/posts/%{name}')
  get '/stories/:name', to: redirect {|path_params, req| "/posts/#{path_params[:name].pluralize}" }
  get '/stories', to: redirect {|path_params, req| "/posts/#{req.subdomain}" }

  # Using Root
  root to: 'pages#main'
  # root 'pages#main' # shortcut for the above


  # Customizing Resourceful Routes
  # Specifying a Controller to Use
  resources :photos, controller: 'images'
  resources :user_permissions, controller: 'admin/user_permissions'

  # Specifying Constraints
  resources :photos, constraints: {id: /[A-Z][A-Z][0-9]+/}

  # Overriding the Named Helpers
  resources :photos, as: 'images'

  # Overriding the new and edit Segments
  resources :photos, path_names: { new: 'make', edit: 'change' }

  # Prefixing the Named Route Helpers
  scope 'admin' do
    resources :photos, as: 'admin_photos'
  end

  scope 'admin', as: 'admin' do
    resources :accounts, :photos
  end

  # Restricting the Routes Created
  resources :photos, only: [:index, :show]
  resources :photos, except: :destroy


  # Inspecting and Testing Routes
  # Listing Existing Routes
  # http://localhost:3000/rails/info/routes
  # rake routes

  # Testing Routes
  # assert_generates
  # assert_recognizes
  # assert_routing

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
