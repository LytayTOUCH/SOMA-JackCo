class AddSubordinateUuidtoLabors < ActiveRecord::Migration
  def change
    add_column :labors, :subordinate_uuid, :string, limit: 36, null: false
  end
end
