class RemoveActiveFromWarehouseTypes < ActiveRecord::Migration
  def change
  	if column_exists? :warehouse_types, :note
      rename_column :warehouse_types, :note, :description
    end

  	if column_exists? :warehouse_types, :active
  	  remove_column :warehouse_types, :active
  	end
  	
  	if column_exists? :warehouse_types, :boolean
	  remove_column :warehouse_types, :boolean
	end
  end
end
