class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.user_group.name == "Administrator"
      can :manage, :all
    else
      # =================== Manager =======================
      can :read, [Labor, Position, PlantingProject, MachineryType, Machinery, EquipmentType, Equipment, MaterialAdjustment, WarehouseProductionAmount, StockIn, WarehouseItemTransaction, InputTask, OutputTask, Farm, Block, Log, PlanFarm, ProductionPlan, ProductionStandard] if user.user_group.name == "Manager"
      
      can :manage, [Warehouse, Material, WarehouseMaterialReceived] if user.user_group.name == "Manager"
      
      can [:edit_profile, :update_profile], User if user.user_group.name == "Manager"

      can :index, :production_plan_report if user.user_group.name == "Manager"
      
      cannot :index, :production_list if user.user_group.name == "Manager"


        
        
      # =================== Project Leader =======================
      can :read, [Labor, Position, MaterialAdjustment, Log] if user.user_group.name == "Project Leader"
      
      can [:edit_profile, :update_profile], User if user.user_group.name == "Project Leader"
      
      can :manage, [Warehouse, Material, PlantingProject, Machinery, MachineryType, EquipmentType, Equipment, WarehouseProductionAmount, WarehouseMaterialReceived, StockIn, WarehouseItemTransaction, InputTask, OutputTask, Farm, Block] if user.user_group.name == "Project Leader"
      
      can [:read, :create], [PlanFarm, ProductionPlan, ProductionStandard] if user.user_group.name == "Project Leader"

      can :index, :production_plan_report if user.user_group.name == "Project Leader"

      cannot :index, :production_list if user.user_group.name == "Project Leader"





      
      # =================== Data Entry =======================
      can [:read, :create], [Labor, Position, MachineryType, Machinery, EquipmentType, Equipment, StockIn, WarehouseItemTransaction, InputTask, OutputTask, PlanFarm, ProductionPlan, ProductionStandard] if user.user_group.name == "Data Entry"

      can :manage, WarehouseMaterialReceived if user.user_group.name == "Data Entry"

      can [:edit_profile, :update_profile], User if user.user_group.name == "Data Entry"

      cannot :index, [:production_list, :production_plan_report] if user.user_group.name == "Data Entry"



      

      
    end
  end 
  
end
