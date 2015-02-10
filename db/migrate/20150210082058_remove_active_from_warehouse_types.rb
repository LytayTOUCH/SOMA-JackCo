class RemoveActiveFromWarehouseTypes < ActiveRecord::Migration
  def change
  	rename_column :warehouse_types, :note, :description
  	remove_column :warehouse_types, :active
  	remove_column :warehouse_types, :boolean
  end
end
