class AlterColumnsInProduction < ActiveRecord::Migration
  def change
    add_column :production_statuses, :stage_id, :string, limit: 36, null: false

    if column_exists? :production_stages, :planting_project_id
      remove_column :production_stages, :planting_project_id
    end
  end
end
