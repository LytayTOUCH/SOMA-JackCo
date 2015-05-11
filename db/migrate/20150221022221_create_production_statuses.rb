class CreateProductionStatuses < ActiveRecord::Migration
  def change
    create_table :production_statuses, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :unit_of_measurement_id, limit: 36, null: false
      t.boolean :active, default: true 
      t.text :note

      t.timestamps
    end
  end
end
