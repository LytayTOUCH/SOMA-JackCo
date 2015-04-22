class CreatePlanProductionStages < ActiveRecord::Migration
  def change
    create_table :plan_production_stages, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :plan_phase_id, limit: 36, null: false
      t.string :production_stage_id, limit: 36, null: false

      t.timestamps
    end
  end
end
