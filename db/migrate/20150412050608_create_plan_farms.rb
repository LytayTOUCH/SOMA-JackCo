class CreatePlanFarms < ActiveRecord::Migration
  def change
    create_table :plan_farms, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :farm_id, limit: 36, null: false
      t.string :planting_project_id, limit: 36, null: false
      t.integer :for_year, null: false
      t.boolean :status, default: true
      
      t.timestamps
    end
  end
end
