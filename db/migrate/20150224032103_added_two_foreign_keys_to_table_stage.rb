class AddedTwoForeignKeysToTableStage < ActiveRecord::Migration
  def change
    add_column :production_stages, :planting_project_id, :string, limit: 36, null: false
    add_column :production_stages, :phase_id, :string, limit: 36, null: false
  end
end
