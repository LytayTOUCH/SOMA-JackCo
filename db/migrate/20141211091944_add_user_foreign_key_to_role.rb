class AddUserForeignKeyToRole < ActiveRecord::Migration
  def change
    add_column :roles, :user_uuid, :string, limit: 36
  end
end
