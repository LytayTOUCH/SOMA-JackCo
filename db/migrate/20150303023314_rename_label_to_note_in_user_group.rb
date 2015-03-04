class RenameLabelToNoteInUserGroup < ActiveRecord::Migration
  def change
    if column_exists? :user_groups, :label
      rename_column :user_groups, :label, :note
    end
  end
end
