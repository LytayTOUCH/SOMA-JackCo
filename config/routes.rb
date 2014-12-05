Rails.application.routes.draw do
  # root 'dashboards#index'
  resources :dashboards, only: [:index]
  resources :machineries, only: [:index]
  resources :tractors, except: [:index]
  resources :implements, except: [:index]
  resources :maintenances, except: [:index]
  resources :implement_types, except: [:destroy]
  resources :suppliers, except: [:destroy]
  resources :materials, except: [:destroy]
  resources :labors, except: [:destroy] do
    collection do 
      get 'projects'
      get 'labors'
    end
  end
  
  devise_for :users
  devise_scope :user do
    get '/' => 'devise/sessions#new'
  end
  resources :accounts, only: [:index]
  
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
