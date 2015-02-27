class AddColumnUserGroupIdAndRemoveRole < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :string, limit: 36, null: false
    remove_column :users, :role
  end
end
