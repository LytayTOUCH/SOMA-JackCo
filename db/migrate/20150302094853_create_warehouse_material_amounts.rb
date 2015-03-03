class CreateWarehouseMaterialAmounts < ActiveRecord::Migration
  def change
    create_table :warehouse_material_amounts, id: false do |t|
      t.string :warehouse_uuid, limit: 36, null: false
      t.string :material_uuid, limit: 36, null: false
      t.float :amount
      t.boolean :returnable, default: false

      t.timestamps
    end
    add_index :warehouse_material_amounts, :warehouse_uuid
    add_index :warehouse_material_amounts, :material_uuid
  end
end

