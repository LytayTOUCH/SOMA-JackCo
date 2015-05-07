Rails.application.routes.draw do

  get 'log_tracking/index'
  
  resources :warehouse_material_amounts, only: [:index, :edit, :update]
  resources :material_adjustments, only: [:index]
  
  get 'get_areas_by_zone', to: 'blocks#get_areas_by_zone'
  
  resources :plan_farms
  get 'get_production_stages', to: 'plan_farms#get_production_stages'
  get 'get_production_statuses', to: 'plan_farms#get_production_statuses'
  get 'get_zone_by_farm', to: 'plan_farms#get_zone_by_farm'
  get 'get_render_block', to: 'plan_farms#get_render_block'

  resources :warehouse_production_amounts, only: [:index, :edit, :update]
  resources :production_adjustments, only: [:index]

  get 'settings' => 'settings#index'
  get 'settings/:code' => 'settings#show', :as => 'setting'
  get 'settings/:code/edit' => 'settings#edit', :as => 'edit_setting'
  patch 'settings/:code', :to => 'settings#update'
  put 'settings/:code', :to => 'settings#update'

  # root 'devise/sessions#new'
  devise_for :users, controllers: { registrations: "users" } 
  # devise_for :users, controllers: { registrations: "registrations" } 
    # as :user do
    #   get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    #   put 'users/:id' => 'devise/registrations#update', :as => 'user_registration'            
    # end
  # devise_for :users, controllers: { registrations: "registrations/registrations" }

  # devise_for :users, controllers: { registrations: "registrations" }

  resources :dashboards, only: [:index] do
    collection do
      get 'getBarData'
      get 'getPieData'
      get 'downloadpdf'
      get 'download_piechart_excel'
      get 'download_barchart_excel'
    end
  end

  resources :plans do
    collection do
      get 'downloadpdf'
      get 'downloadexcel'
    end
  end
  resources :farms do
    collection do
      get 'farms/:farm_id/active_blocks', to: 'blocks#all_active_blocks', as: 'active_blocks'
      get 'farms/:farm_id/inactive_blocks', to: 'blocks#all_inactive_blocks', as: 'inactive_blocks'
      get 'farms/:farm_id/restore_blocks/:id', to: 'blocks#restore_block', as: 'restore_blocks'
    end
    resources :blocks
    collection do
      get 'inactive', to: 'farms#all_inactive_farms', as: 'inactive_farms'
      get 'active', to: 'farms#all_active_farms', as: 'active_farms'
      get 'restore/:id', to: 'farms#restore_farm', as: 'restore_farms'
    end
  end
  
  resources :machinery_types, except: [:destroy]
  resources :machineries, except: [:destroy]

  resources :equipment_types, except: [:destroy]
  resources :equipment, except: [:destroy]

  resources :materials, except: [:destroy] do
    collection do
      get 'new_supplier'
    end
  end

  # resources :labors, except: [:destroy] do
  #   collection do 
  #     get 'projects'
  #     get 'labors'
  #   end
  # end
  
  resources :labors

  devise_scope :user do
    get '/' => 'devise/sessions#new'
  end

  resources :users do
    member do
      get 'edit_profile'
      put 'update_profile'
    end
  end

  resources :accounts, only: [:index]
  put '/dashboards', :to => 'dashboards#index'
  resources :dashboards
  resources :warehouse_types, only: [:index]
  resources :warehouses
  resources :user_groups  
  
  get 'warehouse_item_requested_transactions', to: 'warehouse_item_transactions#index_item_requested', as: :warehouse_item_requested_transactions
  get 'warehouse_item_received_transactions', to: 'warehouse_item_transactions#index_item_received', as: :warehouse_item_received_transactions

  # patch 'permissions/:id/update', :to => 'permissions#update'
  # get ':user_group_id/permissions/new', to: 'permissions#new', as: :permissions_new

  get 'warehouse_material_received/:warehouse_item_requested_transaction_id', to: 'warehouse_material_receiveds#new', as: :new_warehouse_material_received

  get 'new_output_task_from_map/:block_id', to: 'output_tasks#new_output_task_from_map', as: :new_output_task_from_map

  get 'new_input_task_from_map/:block_id', to: 'input_tasks#new_input_task_from_map', as: :new_input_task_from_map

  # put ':user_group_id/permissions/update', to: 'permissions#update', as: :update


  resources :roles do
    collection do
      get 'resources'
    end
  end
  
  resources :calendars
  resources :stages
  resources :coconuts
  resources :jack_fruits
  resources :suppliers

  resources :fields, except: [:destroy] do
    collection do 
      get 'fields'
    end
  end

  resources :activities do
    collection do 
      get 'fields'
      get 'labors'
      get 'tractors'
      get 'implements'
    end
  end

  resources :transaction_status
  resources :planting_projects
  resources :unit_of_measurement
  resources :material_categories
  resources :production_statuses
  resources :production_stages
  resources :positions
  resources :phases
  resources :warehouse_item_transactions
  resources :productions
  resources :stock_ins, only: [:index, :new, :create]
  resources :warehouse_material_receiveds
  resources :output_tasks

  get 'get_material_data', to: 'materials#get_material_data'

  get 'get_unit_of_measurement_data', to: 'materials#get_material_uom_data'

  get 'get_block_planting_project_data', to: 'blocks#get_block_planting_project_data'

  get 'get_machinery_data', to: 'planting_projects#get_machinery_data'
  get 'get_equipment_data', to: 'equipment#get_equipment_data'  

  get 'get_labor_email_data', to: 'labors#get_labor_email'

  get 'get_production_by_planting_project', to: 'blocks#get_production_by_planting_project'

  get 'get_machinery_name', to: 'machineries#get_machinery_name'

  resources :input_tasks
  get 'get_tree_amounts', to: 'blocks#get_tree_amounts'

  get 'get_machinery_name', to: 'machineries#get_machinery_name'
  get 'get_material_name', to: 'materials#get_material_name'
  get 'find_amount', to: 'input_tasks#find_amount'

  # get 'input_uses/index'
  resources :input_uses do
    collection do
      get 'downloadpdf'
    end
  end

  # get 'edit/:id', to: 'users#edit', as: 'edit'

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
