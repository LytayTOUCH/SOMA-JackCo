class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name
      t.string :farm_id

      t.timestamps
    end
  end
end
