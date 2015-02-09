class DeleteColumnBooleanInUserGroup < ActiveRecord::Migration
  def change
    add_column :user_groups, :note, :text
    rename_column :users, :user_group_id, :user_group_uuid
  end
end
