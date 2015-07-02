class AlterWarehouse < ActiveRecord::Migration
  def change
    rename_column :warehouses, :description, :note
    rename_column :warehouse_types, :description, :note
    add_column :users, :note, :text
  end
end
