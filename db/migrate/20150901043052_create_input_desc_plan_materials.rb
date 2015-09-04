class CreateInputDescPlanMaterials < ActiveRecord::Migration
  def change
    create_table :input_desc_plan_materials, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :input_desc_plan_id, limit: 36, null: false
      t.string :category_id, limit: 36, null: false
      t.string :sub_category_id, limit: 36, null: true
      t.integer :no, null: false
      t.string :material_label, null: false
      t.string :material_uom, null: false
      t.string :cd
      t.string :udc
      t.string :ra

      t.timestamps
    end
  end
end
