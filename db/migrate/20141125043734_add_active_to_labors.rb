class AddActiveToLabors < ActiveRecord::Migration
  def change
    add_column :labors, :active, :boolean, default: true
  end
end
