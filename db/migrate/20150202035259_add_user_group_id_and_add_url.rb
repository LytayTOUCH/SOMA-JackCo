class AddUserGroupIdAndAddUrl < ActiveRecord::Migration
  def change
    add_column :users, :user_group_id, :string
    add_column :resources, :url, :string
  end
end
