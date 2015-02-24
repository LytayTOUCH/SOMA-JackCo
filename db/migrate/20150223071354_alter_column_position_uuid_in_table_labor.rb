class AlterColumnPositionUuidInTableLabor < ActiveRecord::Migration
  def change
    if column_exists? :labors, :position_uuid
      rename_column :labors, :position_uuid, :position_id
    end  
  end
end
