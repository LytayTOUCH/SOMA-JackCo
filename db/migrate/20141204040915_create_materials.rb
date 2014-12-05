class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.float :quantity
      t.string :unit, limit: 100
      t.string :supplier_uuid, limit: 36, primary: true
      t.string :warehouse_uuid, limit: 36, primary: true

      t.timestamps
    end
  end
end
