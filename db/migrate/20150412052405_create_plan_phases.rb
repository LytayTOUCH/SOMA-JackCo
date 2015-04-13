class CreatePlanPhases < ActiveRecord::Migration
  def change
    create_table :plan_phases, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :plan_farm_id, limit: 36, null: false
      t.string :phase_id, limit: 36, null: false
      t.string :remark
      
      t.timestamps
    end
  end
end
