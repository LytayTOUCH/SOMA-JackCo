class AddMachineryIdToInputTask < ActiveRecord::Migration
  def change
  	unless column_exists? :input_tasks, :machinery_id
      add_column :input_tasks, :machinery_id, :string, limit: 36
    end
  end
end
