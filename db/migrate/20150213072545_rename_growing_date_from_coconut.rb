class RenameGrowingDateFromCoconut < ActiveRecord::Migration
  def change
  	if column_exists? :coconuts, :growing_date
	  rename_column :coconuts, :growing_date, :planting_date
	end
  end
end
