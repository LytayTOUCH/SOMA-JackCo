class CreateEquipmentTypes < ActiveRecord::Migration
  def change
    create_table :equipment_types, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.boolean :status, default: true
      t.text :note
      t.timestamps
    end
  end
end
