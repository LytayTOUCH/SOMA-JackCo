class RenameColumnTypeInCoconutTable < ActiveRecord::Migration
  def change
    rename_column :coconuts, :type, :coco_type
  end
end
