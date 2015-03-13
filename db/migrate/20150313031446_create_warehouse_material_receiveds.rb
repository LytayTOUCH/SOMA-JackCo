class CreateWarehouseMaterialReceiveds < ActiveRecord::Migration
  def change
    create_table :warehouse_material_receiveds, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :warehouse_item_transaction_id, limit: 36, null: false
      t.date :received_date, null: false
      t.float :received_amount, null: false

      t.timestamps
    end
  end
end
