class AddUserIdToRole < ActiveRecord::Migration
  def change
    rename_column :roles, :user_uuid, :user_id
  end
end
