class ChangePlantingProjectIdFromBlock < ActiveRecord::Migration
  def change
    change_column :blocks, :planting_project_id, :string, limit: 36, null: false
  end
end
