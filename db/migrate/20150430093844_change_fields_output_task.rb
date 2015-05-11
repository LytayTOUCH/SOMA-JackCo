class ChangeFieldsOutputTask < ActiveRecord::Migration
  def change
    unless column_exists? :output_tasks, :farm_id
      add_column :output_tasks, :farm_id, :string, limit: 36, null: false
    end
    unless column_exists? :output_tasks, :zone_id
      add_column :output_tasks, :zone_id, :string, limit: 36, null: false
    end
    unless column_exists? :output_tasks, :area_id
      add_column :output_tasks, :area_id, :string, limit: 36, null: false
    end
    
    if column_exists? :output_tasks, :output_amount
      remove_column :output_tasks, :output_amount
    end
    if column_exists? :output_tasks, :finish_production_id
      remove_column :output_tasks, :finish_production_id
    end
    if column_exists? :output_tasks, :finish_warehouse_id
      remove_column :output_tasks, :finish_warehouse_id
    end
    if column_exists? :output_tasks, :finish_amount
      remove_column :output_tasks, :finish_amount
    end
    if column_exists? :output_tasks, :nursery_production_id
      remove_column :output_tasks, :nursery_production_id
    end
    if column_exists? :output_tasks, :nursery_warehouse_id
      remove_column :output_tasks, :nursery_warehouse_id
    end
    if column_exists? :output_tasks, :nursery_amount
      remove_column :output_tasks, :nursery_amount
    end
    if column_exists? :output_tasks, :spoiled_amount
      remove_column :output_tasks, :spoiled_amount
    end
    if column_exists? :output_tasks, :spoiled_note
      remove_column :output_tasks, :spoiled_note
    end
  end
end
