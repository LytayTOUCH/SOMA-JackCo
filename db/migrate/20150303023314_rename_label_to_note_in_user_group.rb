class RenameLabelToNoteInUserGroup < ActiveRecord::Migration
  def change
    if (column_exists? :user_groups, :label) and not(column_exists? :user_groups, :note)
      rename_column :user_groups, :label, :note
    end
  end
end
