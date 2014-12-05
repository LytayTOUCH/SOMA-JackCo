class CreateResourceUsers < ActiveRecord::Migration
  def change
    create_table :resource_users do |t|
      t.string :resource_id 
      t.string :user_id

      t.timestamps
    end
    add_index :resource_users, ["resource_id", "user_id"]
  end
end
