class CreateLabors < ActiveRecord::Migration
  def change
    create_table :labors, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :position_uuid, limit: 36, null: false
      t.string :labor_project_uuid, limit: 36
      t.string :labor_subordinate, limit: 36
      t.text :description

      t.timestamps
    end
  end
end
