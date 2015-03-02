class CreateWarehouseItemTransactions < ActiveRecord::Migration
  def change
    create_table :warehouse_item_transactions, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :sender_id, limit: 36, null: false
      t.string :receiver_id, limit: 36, null: false
      t.float :material_id, limit: 36, null: false
      t.string :transaction_status, limit: 20, null: false, default: "Requested"
      t.string :requested_number, limit: 40, null: false
      t.string :created_by, limit: 36, null: false
      t.string :updated_by, limit: 36, null: false
      t.datetime :requested_date, null: false, default: Time.now
      t.datetime :received_date
      t.date :due_date
      t.text :note

      t.timestamps
    end
  end
end
