Ticketee::Application.routes.draw do
  
  #APIs
  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :tickets
      end
    end
  end

  namespace :api do
    namespace :v2 do
      resources :projects do
        resources :tickets
      end
    end
  end

  #webpages
  #get "comments/create"

  devise_for :users, controllers: { registrations: "registrations" }

  get '/awaiting_confirmation',
    to: "users#confirmation",
    as: 'confirm_user'

  put '/admin/users/:user_id/permissions',
    to: 'admin/permissions#update',
    as: :update_user_permissions

  resources :files

  resources :projects do
    resources :tickets do
      collection do
        get :search
      end

      member do
        post :watch
      end
    end
  end

  resources :tickets do
    resources :comments
    resources :tags do
      member do
        delete :remove
      end
    end
  end

  namespace :admin do
    root to: "base#index"
    resources :users do
      resources :permissions      
    end
    resources :states do
      member do
        get :make_default
      end
    end
  end


  root to: 'projects#index'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"


end
