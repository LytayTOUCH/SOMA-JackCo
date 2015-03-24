class CreateWarehouseMachineryAmounts < ActiveRecord::Migration
  def change
    create_table :warehouse_machinery_amounts, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :machinery_id, limit: 36, null: false
      t.string :warehouse_id, limit: 36, null: false
      t.float :amount, default: 0
      t.string :status, default: "Ready To Use"
      t.date :available_date, default: nil

      t.timestamps
    end
  end
end
