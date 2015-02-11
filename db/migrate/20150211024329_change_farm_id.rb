class ChangeFarmId < ActiveRecord::Migration
  def change
    if column_exists? :farms, :id
      rename_column :farms, :id, :uuid
    end
  end
end
