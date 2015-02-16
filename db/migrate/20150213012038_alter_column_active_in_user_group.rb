class AlterColumnActiveInUserGroup < ActiveRecord::Migration
  def change
    if column_exists? :users, :active
      change_column :user_groups, :active, :boolean, default: false
    end  
  end
end
