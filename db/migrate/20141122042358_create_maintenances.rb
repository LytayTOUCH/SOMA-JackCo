class CreateMaintenances < ActiveRecord::Migration
  def change
    create_table :maintenances, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :machinery_uuid, limit: 36, null: false
      t.string :labor_uuid, limit: 36
      t.integer :engine_hours
      t.integer :time_spent
      t.text :note
      t.string :maintenance_type, limit: 50, null: false

      t.timestamps
    end
  end
end
