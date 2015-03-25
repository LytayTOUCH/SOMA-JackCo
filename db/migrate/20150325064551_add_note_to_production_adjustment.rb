class AddNoteToProductionAdjustment < ActiveRecord::Migration
  def change
    unless column_exists? :production_adjustments, :note
      add_column :production_adjustments, :note, :text
    end
  end
end
