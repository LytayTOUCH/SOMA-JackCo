class CreateStockIns < ActiveRecord::Migration
  def change
    create_table :stock_ins, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :warehouse_id, limit: 36, null: false
      t.string :material_id, limit: 36, null: false
      t.string :labor_id, limit: 36, null: false
      t.float :amount, default: 0
      t.date :stock_in_date

      t.timestamps
    end
  end
end
