class AddUuidToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :field_uuid, :string, limit: 36
    add_column :activities, :labor_uuid, :string, limit: 36
    add_column :activities, :tractor_uuid, :string, limit: 36
    add_column :activities, :implement_uuid, :string, limit: 36
  end
end
