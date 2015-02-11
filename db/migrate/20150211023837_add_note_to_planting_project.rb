class AddNoteToPlantingProject < ActiveRecord::Migration
  def change
    add_column :planting_projects, :note, :text
  end
end
