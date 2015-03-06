class AlterColumnTransactionStatusAndCreatedByInTableWarehouseItemTransaction < ActiveRecord::Migration
  def change
    if column_exists? :warehouse_item_transactions, :created_by
      change_column :warehouse_item_transactions, :created_by, :string, null: true, limit: 36
    end 

    if column_exists? :warehouse_item_transactions, :transaction_status
      change_column :warehouse_item_transactions, :transaction_status, :string, null: true, limit: 20
    end  
  end
end
