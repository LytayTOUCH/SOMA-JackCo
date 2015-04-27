class CreatePlanZones < ActiveRecord::Migration
  def change
    create_table :plan_zones, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :zone_id, limit: 36, null: false
      t.string :plan_production_status_id, limit: 36, null: false
      t.timestamps
    end
  end
end
