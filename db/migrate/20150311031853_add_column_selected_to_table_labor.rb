class AddColumnSelectedToTableLabor < ActiveRecord::Migration
  def change
    unless column_exists? :labors, :selected
      add_column :labors, :selected, :boolean, default: false
    end
  end
end
