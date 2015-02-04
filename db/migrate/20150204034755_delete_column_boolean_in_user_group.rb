class DeleteColumnBooleanInUserGroup < ActiveRecord::Migration
  def change
    remove_column :resources, :boolean
    remove_column :user_groups, :boolean
    remove_column :permissions, :boolean
    add_column :user_groups, :note, :text
    rename_column :users, :user_group_id, :user_group_uuid
  end
end
