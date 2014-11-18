class CreateTractors < ActiveRecord::Migration
  def change
    create_table :tractors, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.float :horse_power
      t.float :fuel_capacity
      t.string :make
      t.string :model
      t.date :year
      t.float :value
      t.boolean :own, default: false
      t.text :note

      t.timestamps
    end
  end
end
