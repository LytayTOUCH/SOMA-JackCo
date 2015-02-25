class AlterColumnUserGroupInTableUser < ActiveRecord::Migration
  def change
    if column_exists? :users, :email
      change_column :users, :email, :string, limit: 60
    end

    if column_exists? :users, :user_group_id
      change_column :users, :user_group_id, :string, limit: 36, null: false
    end    
  end
end
