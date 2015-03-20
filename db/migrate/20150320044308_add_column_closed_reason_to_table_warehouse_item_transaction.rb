class AddColumnClosedReasonToTableWarehouseItemTransaction < ActiveRecord::Migration
  def change
    unless column_exists? :warehouse_item_transactions, :reason_for_closing_transaction
      add_column :warehouse_item_transactions, :reason_for_closing_transaction, :text
    end  

    if column_exists? :warehouse_item_transactions, :requested_date
      change_column :warehouse_item_transactions, :requested_date, :date, null: false
    end 
  end
end
