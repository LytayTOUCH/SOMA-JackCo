class RemoveOwnInImplements < ActiveRecord::Migration
  def change
    remove_column :implements, :own
  end
end
