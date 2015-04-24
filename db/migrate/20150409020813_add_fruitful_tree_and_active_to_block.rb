class AddFruitfulTreeAndActiveToBlock < ActiveRecord::Migration
  def change
    add_column :blocks, :fruitful_tree, :integer
    add_column :blocks, :active, :boolean
  end
end
