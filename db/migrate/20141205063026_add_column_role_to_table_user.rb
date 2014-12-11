class AddColumnRoleToTableUser < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, limit: 60, null: false
  end
end
