class AddColumnUuidForTableWarehouseMaterialAmount < ActiveRecord::Migration
  def change
    unless column_exists? :warehouse_material_amounts, :uuid
      add_column :warehouse_material_amounts, :uuid, :string, limit: 36, primary: true, null: false
    end  
  end
end
