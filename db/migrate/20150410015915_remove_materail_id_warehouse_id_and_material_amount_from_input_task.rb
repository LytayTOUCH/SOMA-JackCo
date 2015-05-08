class RemoveMaterailIdWarehouseIdAndMaterialAmountFromInputTask < ActiveRecord::Migration
  def change
  	if column_exists? :input_tasks, :warehouse_id
      remove_column :input_tasks, :warehouse_id
    end 
    if column_exists? :input_tasks, :material_id
      remove_column :input_tasks, :material_id
    end 
    if column_exists? :input_tasks, :material_amount
      remove_column :input_tasks, :material_amount
    end 
    
  end
end
