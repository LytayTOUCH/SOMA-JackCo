class CreateOutputTasks < ActiveRecord::Migration
  def change
    create_table :output_tasks, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :block_id, limit: 36, null: false
      t.string :planting_project_id, limit: 36, null: false
      t.integer :tree_amount
      t.string :labor_id, limit: 36, null: false
      t.string :reference_number
      t.float :out_amount
      t.string :finish_production_id, limit: 36, null: false
      t.string :finish_warehouse_id, limit: 36, null: false
      t.float :finish_amount
      t.string :nursery_production_id, limit: 36, null: false
      t.string :nursery_warehouse_id, limit: 36, null: false
      t.float :nursery_amount
      t.float :spoiled_amount
      t.string :spoiled_note
      t.text :note
      t.string :created_by, limit: 36, null: false
      t.string :updated_by, limit: 36, null: false

      t.timestamps
    end
  end
end
