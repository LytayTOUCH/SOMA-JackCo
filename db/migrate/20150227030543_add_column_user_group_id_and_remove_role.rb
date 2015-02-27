class AddColumnUserGroupIdAndRemoveRole < ActiveRecord::Migration
  def change
  	if column_exists? :users, :role
	  remove_column :users, :role
	end
  	
  	unless column_exists? :users, :user_group_id
		add_column :users, :user_group_id, :string, limit: 36, null: false
	end
    
  end
end
