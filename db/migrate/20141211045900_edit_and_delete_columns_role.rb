class EditAndDeleteColumnsRole < ActiveRecord::Migration
  def change
    remove_column :roles, :resource_id
    remove_column :roles, :resource_type
    add_column :roles, :label, :string
  end
end
