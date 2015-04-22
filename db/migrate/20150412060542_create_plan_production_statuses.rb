class CreatePlanProductionStatuses < ActiveRecord::Migration
  def change
    create_table :plan_production_statuses, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :plan_production_stage_id, limit: 36, null: false
      t.string :production_status_id, limit: 36, null: false
      t.string :remark
      
      t.timestamps
    end
  end
end
