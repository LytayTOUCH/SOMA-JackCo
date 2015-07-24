class CreateProcessPlans < ActiveRecord::Migration
  def change
    create_table :process_plans, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.integer :year, null: false
      t.string :planting_project_id, limit: 36, null: false

      t.timestamps
    end
    
    add_index(:process_plans, [:year, :planting_project_id], unique: true, name: 'by_planting_project_year')
  end
end
