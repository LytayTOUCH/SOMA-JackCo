Rails.application.routes.draw do

  get 'nursery_balances', to: 'nursery_balances#index'
  get 'create_nursery_balance', to: 'nursery_balances#create'

  get 'plan_processes/index'
  get 'plan_processes/new'
  post 'plan_processes/create'

  get 'plan_input_descs/index'
  get 'plan_input_descs/new'
  post 'plan_input_descs/create'

  get 'support', to: 'helps#support'
  get 'user_manual', to: 'helps#user_manual'
  
  resources :coconut_nursery_inputs, except: [:destroy]
  get 'get_qty_production_in_stock', to: 'warehouses#get_qty_production_in_stock'
  get 'get_project_warehouse_data', to: 'warehouses#get_project_warehouse_data'
  
  resources :production_standards

  resources :production_plans
  get 'get_production_classification', to: 'production_plans#get_production_classification'

  resources :production_plan_report
  get 'get_production_plan_tree', to: 'production_plan_report#get_production_plan_tree'

  resources :production_list
  
  resources :apps, except: [:destroy]
  
  resources :stock_balances, only: [:index]
  get 'update_stock_balance', to: 'stock_balances#update'
  get 'adjust_stock_balance', to: 'stock_balances#adjust_form'
  get 'update_adjust_balance', to: 'stock_balances#update_adjust_balance'
  get 'report_inventory', to: 'stock_balances#report_inventory'

  get 'report_productivities/coconut_index'
  get 'report_productivities/jackfruit_index'
  
  get 'report_classifications/coconut_index'
  get 'report_classifications/jackfruit_index'
  
  get 'report_nurseries/coconut_index'

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
    resources :blocks
    collection do
      get 'farms/:farm_id/active_blocks', to: 'blocks#all_active_blocks', as: 'active_blocks'
      get 'farms/:farm_id/inactive_blocks', to: 'blocks#all_inactive_blocks', as: 'inactive_blocks'
      get 'farms/:farm_id/restore_blocks/:id', to: 'blocks#restore_block', as: 'restore_blocks'

      get 'inactive', to: 'farms#all_inactive_farms', as: 'inactive_farms'
      get 'active', to: 'farms#all_active_farms', as: 'active_farms'
      get 'restore/:id', to: 'farms#restore_farm', as: 'restore_farms'

      get ':farm_id/new_zone', to: 'blocks#new_zone', as: 'new_zone'
      post ':farm_id/create_zone', to: 'blocks#create_zone', as: 'create_zone'
      delete ':farm_id/zone/:zone_id', to: 'blocks#destroy_zone', as: 'destroy_zone'

      get ':farm_id/new_area', to: 'blocks#new_area', as: 'new_area'
      post ':farm_id/create_area', to: 'blocks#create_area', as: 'create_area'
      delete ':farm_id/area/:area_id', to: 'blocks#destroy_area', as: 'destroy_area'
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

  resources :calendars
  resources :stages

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
  get 'add_new_labor_out_task', to: "output_tasks#add_new_labor", as: :add_new_labor_out_task
  post 'save_new_labor_out_task', to: "output_tasks#save_new_labor", as: :save_new_labor_out_task

  get 'get_material_data', to: 'materials#get_material_data'
  get 'get_input_material_data', to: 'materials#get_input_material_data'

  get 'get_unit_of_measurement_data', to: 'materials#get_material_uom_data'
  get 'get_indirect_other_material_data', to: 'materials#get_indirect_other_material_data'

  get 'get_block_planting_project_data', to: 'blocks#get_block_planting_project_data'
  get 'get_area_planting_project_data', to: 'blocks#get_area_planting_project_data'

  get 'get_machinery_data', to: 'planting_projects#get_machinery_data'
  get 'get_equipment_data', to: 'equipment#get_equipment_data'
  get 'get_output_equipment_data', to: 'equipment#get_output_equipment_data'
  get 'get_input_equipment_data', to: 'equipment#get_input_equipment_data'

  get 'get_labor_email_data', to: 'labors#get_labor_email'

  get 'get_production_by_planting_project', to: 'blocks#get_production_by_planting_project'

  resources :input_tasks
  get 'add_new_labor_input_task', to: "input_tasks#add_new_labor", as: :add_new_labor_input_task
  post 'save_new_labor_input_task', to: "input_tasks#save_new_labor", as: :save_new_labor_input_task

  get 'get_tree_amounts', to: 'blocks#get_tree_amounts'
  get 'get_tree_amounts_in_area', to: 'blocks#get_tree_amounts_in_area'

  get 'get_machinery_name', to: 'machineries#get_machinery_name'
  get 'get_input_machinery_data', to: 'machineries#get_input_machinery_data'
  get 'get_material_name', to: 'materials#get_material_name'
  
  get 'get_zones_by_farm', to: 'output_tasks#get_zones_by_farm'
  get 'get_blocks_by_area', to: 'output_tasks#get_blocks_by_area'
  get 'get_distributions_by_planting_project', to: 'output_tasks#get_distributions_by_planting_project'
  
  get 'get_warehouse_material_amount_data', to: 'warehouse_material_amounts#get_warehouse_material_amount_data'
  get 'get_input_application_data', to: 'input_tasks#get_application_data'
  get 'get_output_application_data', to: 'output_tasks#get_application_data'
  get 'get_application_data', to: 'apps#get_application_data'
  get 'find_amount', to: 'input_tasks#find_amount'

  scope 'input_uses', as: 'input_uses' do
    get 'jackfruit', to: 'input_uses#index'
    get 'coconut', to: 'input_uses#index'
  end



  # resources :input_uses

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
