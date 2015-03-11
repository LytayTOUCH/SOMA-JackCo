class CreateWarehouseProductionAmounts < ActiveRecord::Migration
  def change
    create_table :warehouse_production_amounts, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :warehouse_id, limit: 36, null: false
      t.string :production_id, limit: 36, null: false
      t.float :amount, default: 0

      t.timestamps
    end
  end
end
