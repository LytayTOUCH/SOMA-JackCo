class AddFarmIdZoneIdAreaIdToInputTask < ActiveRecord::Migration
  def change
  	unless column_exists? :input_tasks, :farm_id
      add_column :input_tasks, :farm_id, :string, limit: 36, null: false
    end
    unless column_exists? :input_tasks, :zone_id
      add_column :input_tasks, :zone_id, :string, limit: 36, null: false
    end
    unless column_exists? :input_tasks, :area_id
      add_column :input_tasks, :area_id, :string, limit: 36, null: false
    end
  end
end
