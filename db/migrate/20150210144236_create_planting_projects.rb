class CreatePlantingProjects < ActiveRecord::Migration
  def change
    create_table :planting_projects, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :project_name, limit: 50, null: false

      t.timestamps
    end
  end
end
