class RemoveColumnRecieverAndRecievedDateFromTableWarehouseItemTransaction < ActiveRecord::Migration
  def change
    if column_exists? :warehouse_item_transactions, :received_date
      remove_column :warehouse_item_transactions, :received_date
    end 
    unless column_exists? :warehouse_item_transactions, :remaining_amount
      add_column :warehouse_item_transactions, :remaining_amount, :float
    end
  end
end
