class AlterColumnInTablePermission < ActiveRecord::Migration
  def change
    if column_exists? :permissions, :name
      change_column :permissions, :name, :string, limit: 50
    end  
    if column_exists? :permissions, :user_group_id
      change_column :permissions, :user_group_id, :string, limit: 36
    end  
    if column_exists? :permissions, :resource_id
      change_column :permissions, :resource_id, :string, limit: 36
    end  
  end
end