class CreateProcessPlanMaterials < ActiveRecord::Migration
  def change
    create_table :process_plan_materials, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :process_plan_id, limit: 36, null: false
      t.string :app_id, limit: 36, null: false
      t.string :app_description_id, limit: 36, null: false
      t.string :process_plan_category_id, limit: 36, null: false
      t.string :material_label, limit: 255, null: false
      t.boolean :material_value, default: false

      t.timestamps
    end
  end
end
