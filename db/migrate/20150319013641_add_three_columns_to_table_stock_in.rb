class AddThreeColumnsToTableStockIn < ActiveRecord::Migration
  def change
    unless column_exists? :stock_ins, :reference_number
      add_column :stock_ins, :reference_number, :string, limit: 30, null: false
    end  

    unless column_exists? :stock_ins, :item_desc
      add_column :stock_ins, :item_desc, :text
    end  

    unless column_exists? :stock_ins, :note
      add_column :stock_ins, :note, :text
    end  
  end
end
