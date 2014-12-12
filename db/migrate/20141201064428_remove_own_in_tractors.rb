class RemoveOwnInTractors < ActiveRecord::Migration
  def change
    remove_column :tractors, :own
  end
end
