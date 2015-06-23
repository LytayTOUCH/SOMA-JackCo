class CreateProductionInWarehouses < ActiveRecord::Migration
  def change
    create_table :production_in_warehouses, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :warehouse_id, limit: 36, null: false
      t.string :distribution_id, limit: 36, null: false
      t.string :unit_measure_id, limit: 36, null: false
      t.float :amount, default: 0

      t.timestamps
    end
    
    add_index(:production_in_warehouses, [:warehouse_id, :distribution_id, :unit_measure_id], unique: true, name: 'by_warehouse_distribution_uom')
  end
end
