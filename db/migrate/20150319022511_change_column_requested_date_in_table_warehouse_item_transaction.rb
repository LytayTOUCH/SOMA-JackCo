class ChangeColumnRequestedDateInTableWarehouseItemTransaction < ActiveRecord::Migration
  def change
    if column_exists? :warehouse_item_transactions, :requested_date
      change_column :warehouse_item_transactions, :requested_date, :date, null: false, default: Date.today
    end  
  end
end
