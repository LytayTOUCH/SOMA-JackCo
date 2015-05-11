class CreateProductionPlans < ActiveRecord::Migration
  def change
    create_table :production_plans, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.integer :for_year, null: false
      t.string :planting_project_id, limit: 36, null: false
      t.float :jan
      t.float :feb
      t.float :mar
      t.float :apr
      t.float :may
      t.float :jun
      t.float :jul
      t.float :aug
      t.float :sep
      t.float :oct
      t.float :nov
      t.float :dec
      
      t.timestamps
    end
  end
end
