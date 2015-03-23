class AddActiveToFarms < ActiveRecord::Migration
  def change
    add_column :farms, :active, :boolean
  end
end
