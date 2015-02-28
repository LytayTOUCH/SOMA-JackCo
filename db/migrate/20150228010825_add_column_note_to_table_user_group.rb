class AddColumnNoteToTableUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :note, :text
  end
end
