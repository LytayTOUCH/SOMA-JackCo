class CreateInputTasks < ActiveRecord::Migration
  def change
    create_table :input_tasks, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :block_id, limit: 36, null: false
      t.integer :tree_amount
      t.string :labor_id, limit: 36, null: false
      t.string :reference_number
      t.string :warehouse_id, limit: 36, null: false
      t.string :material_id, limit: 36, null: false
      t.float :material_amount
      t.text :note
      t.string :created_by, limit: 36, null: false
      t.string :updated_by

      t.timestamps
    end
  end
end
