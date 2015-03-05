class RenameDescriptionFromWarehouseTypes < ActiveRecord::Migration
  def change
  	if column_exists? :warehouse_types, :description
	    rename_column :warehouse_types, :description, :note
	  end
  end
end
