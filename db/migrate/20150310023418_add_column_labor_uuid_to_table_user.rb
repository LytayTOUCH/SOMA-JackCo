class AddColumnLaborUuidToTableUser < ActiveRecord::Migration
  def change
    unless column_exists? :users, :labor_id
      add_column :users, :labor_id, :string, limit: 36, null: false
    end
  end
end
