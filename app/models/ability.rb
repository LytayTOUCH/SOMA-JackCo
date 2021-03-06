class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.user_group.name == "Administrator"
      can :manage, :all
    else
      # =================== Manager =======================
      can :read, [Labor, Position, PlantingProject, MachineryType, Machinery, EquipmentType, Equipment, MaterialAdjustment, WarehouseProductionAmount, StockIn, WarehouseItemTransaction, InputTask, OutputTask, Farm, Block, Log, PlanFarm, ProductionPlan, ProductionStandard, WarehouseMaterialAmount] if user.user_group.name == "Manager"
      
      can :manage, [App, Warehouse, Material, WarehouseMaterialReceived] if user.user_group.name == "Manager"
      
      can [:edit_profile, :update_profile], User if user.user_group.name == "Manager"

      can :index, [:production_plan_report, :production_list, :input_uses] if user.user_group.name == "Manager"
      
      can [:coconut_index, :jackfruit_index], [:report_productivities, :report_classifications] if user.user_group.name == "Manager"

        
      # =================== Project Leader =======================
      can :read, [Labor, Position, MaterialAdjustment, Log] if user.user_group.name == "Project Leader"
      
      can [:edit_profile, :update_profile], User if user.user_group.name == "Project Leader"
      
      can :manage, [ProductionInWarehouse, Warehouse, Material, PlantingProject, Machinery, MachineryType, EquipmentType, Equipment, WarehouseProductionAmount, WarehouseMaterialReceived, StockIn, WarehouseItemTransaction, Farm, Block, StockBalance, WarehouseMaterialAmount] if user.user_group.name == "Project Leader"
      
      can [:read, :create], [App, PlanFarm, ProductionPlan, OutputTask, InputTask, ProductionStandard] if user.user_group.name == "Project Leader"

      can :index, [:production_plan_report, :production_list, :input_uses] if user.user_group.name == "Project Leader"

      can [:coconut_index, :jackfruit_index, :adjust_form], [:report_productivities, :report_classifications, :stock_balance] if user.user_group.name == "Project Leader"





      
      # =================== Data Entry =======================
      cannot :read, App if user.user_group.name == "Data Entry"
      
      can [:read, :create], [Labor, Position, MachineryType, Machinery, EquipmentType, Equipment, StockIn, WarehouseItemTransaction, InputTask, OutputTask, PlanFarm, ProductionPlan, ProductionStandard] if user.user_group.name == "Data Entry"

      can :manage, WarehouseMaterialReceived if user.user_group.name == "Data Entry"

      can [:edit_profile, :update_profile], User if user.user_group.name == "Data Entry"

      cannot :index, [:production_list, :production_plan_report, :input_uses] if user.user_group.name == "Data Entry"

      cannot [:coconut_index, :jackfruit_index], [:report_productivities, :report_classifications] if user.user_group.name == "Data Entry"

      
    end
  end 
  
end
