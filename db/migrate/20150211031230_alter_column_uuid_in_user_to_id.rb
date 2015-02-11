class AlterColumnUuidInUserToId < ActiveRecord::Migration
  def change
    if column_exists? :users, :user_group_uuid
      rename_column :users, :user_group_uuid, :user_group_id
    end  
  end
end
