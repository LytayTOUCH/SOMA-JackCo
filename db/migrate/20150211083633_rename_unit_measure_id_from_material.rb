class RenameUnitMeasureIdFromMaterial < ActiveRecord::Migration
  def change
  	if column_exists? :materials, :material_cate_id
	  rename_column :materials, :material_cate_id, :material_cate_uuid
	end
	if column_exists? :materials, :unit_measure_id
	  rename_column :materials, :unit_measure_id, :unit_measure_uuid
	end

  end
end
