class ChangeYearDataTypeTractors < ActiveRecord::Migration
  def change
    change_column :tractors, :year, :string, limit: 10
  end
end
