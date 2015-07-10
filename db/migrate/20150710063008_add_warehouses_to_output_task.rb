class AddWarehousesToOutputTask < ActiveRecord::Migration
  def change
    unless column_exists? :output_tasks, :nursery_warehouse_id
      add_column :output_tasks, :nursery_warehouse_id, :string, limit: 36
    end
    unless column_exists? :output_tasks, :finish_warehouse_id
      add_column :output_tasks, :finish_warehouse_id, :string, limit: 36
    end
  end
end
