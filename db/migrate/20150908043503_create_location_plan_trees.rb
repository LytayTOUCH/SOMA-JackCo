class CreateLocationPlanTrees < ActiveRecord::Migration
  def change
    create_table :location_plan_trees, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :location_plan_id, limit: 36, null: false
      t.string :status_id, limit: 36, null: false
      t.string :area_id, limit: 36, null: false
      t.integer :tree_value, null: false

      t.timestamps
    end
  end
end
