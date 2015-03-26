class AddNoteToMaterialAdjustment < ActiveRecord::Migration
  def change
    unless column_exists? :material_adjustments, :note
      add_column :material_adjustments, :note, :text
    end
  end
end
