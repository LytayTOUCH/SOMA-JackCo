class CreateStockBalances < ActiveRecord::Migration
  def change
    create_table :stock_balances, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :material_id, limit: 36, null: false
      t.string :material_category_id, limit: 36, null: false
      t.integer :month, null: false
      t.integer :year, null: false
      t.float :stock_in, default: 0
      t.float :stock_out, default: 0
      t.float :beginning_balance, default: 0
      t.float :ending_balance, default: 0
      t.float :adjusted_ending_balance, null: true
      t.text :adjusted_note, null: true
      
      t.timestamps
    end
    
    add_index(:stock_balances, [:material_id, :month, :year], unique: true)
  end
end
