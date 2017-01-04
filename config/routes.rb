Rails.application.routes.draw do
 
  get 'welcome/index'
  root 'welcome#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'search/index'

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "about" => "about#index", :as => "about"
  get 'hosts' => "hosts#index", :as => "hosts"

  get 'super_user' => 'super_user#index', as: :super_user #might trim this a little
  post 'do/super_user', action: 'do', controller: 'super_user'

  get 'find_open_venue', action: 'index', controller: 'venue_finder'
  post 'find_open_venue/find_venue' => 'venue_finder#find_venue', as: :find_venue
  

  get "search" => "accommodation#search", :as => "search"


  resources :localsession
  resources :users do
    member do
      get 'panel', action: :panel
    end
  end
  resources :sessions
  #resources :category  removed it
  resources :books
  resources :accommodations do
    member do
      post 'secure_room', :action => :secure_room
      post  'pay', action: :pay
      post 'student_pay', action: :student_pay #todo
      delete 'cancel', action: :cancel #todo
      post 'go_ahead', action: :go_ahead
    end
    collection do
      get 'search', :action => :search
    end
  end

  resources :items do
    member do
      post :like
      get :likes
    end
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
