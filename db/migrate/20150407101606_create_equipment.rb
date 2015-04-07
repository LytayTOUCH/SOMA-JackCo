class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment, id: false do |t|
    	t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :equipment_type_id, limit: 36, null: false
      t.text :note
      t.boolean :status, default: true
      t.string :planting_project_id, limit: 36, null: false
      t.timestamps
    end
  end
end
