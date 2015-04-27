class CreateInputUseEquipments < ActiveRecord::Migration
  def change
    create_table :input_use_equipments, id: false do |t|
    	t.string :uuid, limit: 36, primary: true, null: false
    	t.string :input_id, limit: 36, null: false
    	t.string :equipment_id, limit: 36, null: false


      t.timestamps
    end
  end
end
