class AlterColumnActiveInTableUserGroup < ActiveRecord::Migration
  def change
    if column_exists? :user_groups, :active
      change_column :user_groups, :active, :boolean, default: false
    end
  end
end
