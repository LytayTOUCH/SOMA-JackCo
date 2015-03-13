class RemoveColumnRecieverAndRecievedDateFromTableWarehouseItemTransaction < ActiveRecord::Migration
  def change
    if column_exists? :warehouse_item_transactions, :receiver_id
      remove_column :warehouse_item_transactions, :receiver_id
    end 
  end
end
