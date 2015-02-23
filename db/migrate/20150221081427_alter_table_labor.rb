class AlterTableLabor < ActiveRecord::Migration
  def change
    add_column :labors, :gender, :string, limit: 1
    add_column :labors, :phone, :string, limit: 15
    add_column :labors, :email, :string, limit: 30
    add_column :labors, :address, :text
    rename_column :labors, :description, :note
    rename_column :labors, :subordinate_uuid, :manager_uuid, null: true
  end
end
