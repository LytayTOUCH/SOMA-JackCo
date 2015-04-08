class RenameColumnWarehouseIdToPlantingProjectInTableMachinery < ActiveRecord::Migration
  def change
    if column_exists? :machineries, :warehouse_id
      rename_column :machineries, :warehouse_id, :planting_project_id
    end  
  end
end
