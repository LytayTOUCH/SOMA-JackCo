class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :labor_uuid, limit: 36
      t.string :warehouse_type_uuid, limit: 36
      t.string :address
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
