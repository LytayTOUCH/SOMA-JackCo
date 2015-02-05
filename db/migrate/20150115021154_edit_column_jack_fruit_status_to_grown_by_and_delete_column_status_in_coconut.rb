class EditColumnJackFruitStatusToGrownByAndDeleteColumnStatusInCoconut < ActiveRecord::Migration
  def change
    rename_column :jack_fruits, :status, :grown_by
    rename_column :jack_fruits, :growing_date, :planting_date
    remove_column :coconuts, :status
  end
end
