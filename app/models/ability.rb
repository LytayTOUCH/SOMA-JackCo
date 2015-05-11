class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    if user.user_group.name == "Administrator"
      can :manage, :all
    else
      # =================== Manager =======================
      can :read, [Labor, Position, PlantingProject, MachineryType, Machinery, EquipmentType, Equipment, ProductionAdjustment, WarehouseProductionAmount, StockIn, WarehouseItemTransaction, InputTask] if user.user_group.name == "Manager"
      can :manage, [Warehouse, Material, WarehouseMaterialReceived] if user.user_group.name == "Manager"


      # =================== Manager =======================
      can :manage, WarehouseMaterialReceived if user.user_group.name == "Data Entry"
        
      end
      # =================== Manager =======================
      can :manage, WarehouseMaterialReceived if user.user_group.name == "Project Leader"
      
    end
  end 
  
end
