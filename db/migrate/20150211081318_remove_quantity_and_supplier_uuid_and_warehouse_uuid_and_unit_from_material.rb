class RemoveQuantityAndSupplierUuidAndWarehouseUuidAndUnitFromMaterial < ActiveRecord::Migration
  def change 	
  	if column_exists? :materials, :quantity
	  remove_column :materials, :quantity
	end
	if column_exists? :materials, :unit
	  remove_column :materials, :unit
	end
	if column_exists? :materials, :supplier_uuid
	  remove_column :materials, :supplier_uuid
	end
	if column_exists? :materials, :warehouse_uuid
	  remove_column :materials, :warehouse_uuid
	end
  	
  	unless column_exists? :materials, :material_cate_id
  		add_column :materials, :material_cate_id, :string, limit: 36, primary: true
	end
	unless column_exists? :materials, :unit_measure_id
  		add_column :materials, :unit_measure_id, :string, limit: 36, primary: true
	end
	unless column_exists? :materials, :supplier
  		add_column :materials, :supplier, :string
	end
	unless column_exists? :materials, :note
  		add_column :materials, :note, :text
	end

  end
end
