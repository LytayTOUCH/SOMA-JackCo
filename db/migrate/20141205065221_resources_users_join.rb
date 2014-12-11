class ResourcesUsersJoin < ActiveRecord::Migration
  def change
    create_table :resources_users, id: false do |t|
      t.string :resource_uuid
      t.string :user_uuid
    end  
    add_index :resources_users, ["resource_uuid", "user_uuid"]  
  end
end
