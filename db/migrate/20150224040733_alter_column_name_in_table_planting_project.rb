class AlterColumnNameInTablePlantingProject < ActiveRecord::Migration
  def change
    if column_exists? :planting_projects, :project_name
      rename_column :planting_projects, :project_name, :name
  	end
  end
end
