Rails.application.routes.draw do
  resources :primers
  resources :manuals do
    get 'download_file', :on => :member
    get 'view_file', :on => :member
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :responsibilities
  resources :fronts
  resources :regular_chemicals
  resources :mol_biol_chemicals
  resources :bacterial_stocks

  root to: 'fronts#index'

  # resources :sequence_attachments
  # resources :sequences, :collection => {:checked => :put}
  get 'primers' => 'primers#index', as: :primers
  # get 'bacterial_stocks' => 'bacterial_stocks#index', as: :bacterial_stocks

  resources :sequences do
    get 'checked', :on => :member
    # member do
    #   post 'toggle'
    # end
    resources :bacterial_stocks, except: :index
    resources :primers, except: :index
    resources :sequence_attachments do
      get 'download_file', :on => :member
      get 'view_file', :on => :member
    end
  end

  get "/login" => "sessions#new", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"
  
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
