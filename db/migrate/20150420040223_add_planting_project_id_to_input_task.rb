class AddPlantingProjectIdToInputTask < ActiveRecord::Migration
  def change
  	unless column_exists? :input_tasks, :planting_project_id
      add_column :input_tasks, :planting_project_id, :string, limit: 36, null: false
    end
    if column_exists? :input_tasks, :machinery_id
      remove_column :input_tasks, :machinery_id
    end
  end
end
