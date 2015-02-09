class CreateWarehouseTypes < ActiveRecord::Migration
  def change
    create_table :warehouse_types, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.text :description 
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
