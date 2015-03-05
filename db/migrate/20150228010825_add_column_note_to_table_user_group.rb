class AddColumnNoteToTableUserGroup < ActiveRecord::Migration
  def change
    unless column_exists? :user_groups, :note
      add_column :user_groups, :note, :text
    end
  end
end
