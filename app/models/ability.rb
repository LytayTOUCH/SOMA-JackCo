class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.user_group.name == "Administrator"
      can :manage, :all
    else
      # =================== Manager =======================
      can :read, [Labor, Position, PlantingProject, MachineryType, Machinery, EquipmentType, Equipment, ProductionAdjustment, WarehouseProductionAmount, StockIn, WarehouseItemTransaction, InputTask, OutputTask, Farm, Block] if user.user_group.name == "Manager"
      can :manage, [Warehouse, Material, WarehouseMaterialReceived] if user.user_group.name == "Manager"
      can [:edit_profile, :update_profile], User if user.user_group.name == "Manager"
      can [:read, :print], PlanFarm if user.user_group.name == "Manager"
        
      # =================== Project Leader =======================
      can :read, [Labor, Position, ProductionAdjustment, WarehouseProductionAmount, StockIn, WarehouseItemTransaction, InputTask, OutputTask, Farm, Block] if user.user_group.name == "Project Leader"
      can [:edit_profile, :update_profile], User if user.user_group.name == "Project Leader"
      can :manage, [Warehouse, Material, PlantingProject, Machinery, MachineryType, EquipmentType, Equipment, WarehouseMaterialReceived] if user.user_group.name == "Project Leader"
      
      # =================== Data Entry =======================
      can :manage, WarehouseMaterialReceived if user.user_group.name == "Data Entry"
      
    end
  end 
  
end
