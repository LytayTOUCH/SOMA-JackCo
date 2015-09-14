class CreateLocationPlanOthers < ActiveRecord::Migration
  def change
    create_table :location_plan_others, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :location_plan_id, limit: 36, null: false
      t.string :status_id, limit: 36, null: false
      t.string :spacing
      t.string :remark
      t.integer :total

      t.timestamps
    end
  end
end
