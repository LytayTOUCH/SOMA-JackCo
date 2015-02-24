class AddColumnActiveToTableStage < ActiveRecord::Migration
  def change
    if table_exists? :stages
      add_column :stages, :active, :boolean, default: true, null: false
    end
  end
end
