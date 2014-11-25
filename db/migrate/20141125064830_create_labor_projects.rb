class CreateLaborProjects < ActiveRecord::Migration
  def change
    create_table :labor_projects, id: false do |t|
      t.string :labor_uuid, limit: 36, null: false
      t.string :project_uuid, limit: 36, null: false

      t.timestamps
    end
  end
end
