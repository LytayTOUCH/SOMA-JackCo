class CreateInputUseMachineries < ActiveRecord::Migration
  def change
    create_table :input_use_machineries, id: false do |t|
    	t.string :uuid, limit: 36, primary: true, null: false
    	t.string :input_id, limit: 36, null: false
    	t.string :machinery_id, limit: 36, null: false
    	t.string :warehouse_id, limit: 36, null: false
    	t.string :material_id, limit: 36, null: false   	
      t.float :material_amount

      t.timestamps
    end
  end
end
