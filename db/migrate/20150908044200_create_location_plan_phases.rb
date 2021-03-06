class CreateLocationPlanPhases < ActiveRecord::Migration
  def change
    create_table :location_plan_phases, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, null: false
      t.string :planting_project_id, limit: 36, null: false

      t.timestamps
    end
  end
end
