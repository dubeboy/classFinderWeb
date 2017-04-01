Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'comments/index'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'comments/com'
    end
  end

  get 'select_user_type/index'

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
  get 'hosts/user_type' => "hosts#user_type", as: "hosts/user_type"
  post 'hosts/choose_user_type' => "hosts#choose_user_type", as: "hosts/choose_user_type"

  get 'super_user' => 'super_user#index', as: :super_user #might trim this a little
  get 'books_list' => 'super_user#books_list'
  post 'super_user', action: :change_runner, controller: 'super_user'
  post 'do/super_user', action: 'do', controller: 'super_user'

  get 'find_open_venue', action: 'index', controller: 'venue_finder'
  post 'find_open_venue/find_venue' => 'venue_finder#find_venue', as: :find_venue
  

  resources :localsession
  resources :users do
    member do
      get 'panel', action: :panel
      get 'books_panel', action: :books_panel
    end
  end
  resources :sessions
  #resources :category  removed it
  resources :books do
    member do
      post 'buy', action: :buy
      post 'sold', action: :sold
    end
  end
  resources :accommodations do
    member do
      post 'secure_room', :action => :secure_room
      post  'pay', action: :pay
      post 'student_pay', action: :student_pay #todo protect all of them they are not protected

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

  # our api routes should be extracted to its own app yoh  , Reformat man!!!
    namespace :api do
      namespace :v1 do
        get 'venue_finder/index'
        resources :sessions
        resources :networks do
          resources :network_posts do
            post 'like', action: :like
            resources :comments
          end 
        end
        resources :books do
          collection do
           get 'search', :action => :search # yeah its a get
          end 
        end 
       resources :users do
         member do
          get 'panel', action: :panel
         end
         collection do
          get 'user_exits', action: :check_if_user_exits 
         end
        end
        resources :accommodations do
          member do
            post 'secure_room', :action => :secure_room
            post  'pay', action: :pay
            post 'student_pay', action: :student_pay #todo protect all of them they are not protected

            delete 'cancel', action: :cancel #todo
            post 'go_ahead', action: :go_ahead
          end
          collection do
            get 'search', :action => :search
          end
        end
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
