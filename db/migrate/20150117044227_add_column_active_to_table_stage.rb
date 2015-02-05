class AddColumnActiveToTableStage < ActiveRecord::Migration
  def change
    add_column :stages, :active, :boolean, default: true, null: false
  end
end
