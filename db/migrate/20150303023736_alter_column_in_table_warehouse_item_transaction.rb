class AlterColumnInTableWarehouseItemTransaction < ActiveRecord::Migration
  def change
    if column_exists? :warehouse_item_transactions, :updated_by
      change_column :warehouse_item_transactions, :updated_by, :string, null: true, limit: 36
    end 
    if column_exists? :warehouse_item_transactions, :requested_date
      change_column :warehouse_item_transactions, :requested_date, :date, null: false
    end  
    if column_exists? :warehouse_item_transactions, :received_date
      change_column :warehouse_item_transactions, :received_date, :date
    end 
    if column_exists? :warehouse_item_transactions, :due_date
      change_column :warehouse_item_transactions, :due_date, :date, null: false
    end 
  end
end
