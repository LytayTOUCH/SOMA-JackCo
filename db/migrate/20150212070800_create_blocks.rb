class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name
      t.integer :surface
      t.text :shape_lat_long
      t.string :location_lat_long
      t.integer :tree_amount
      t.string :farm_id
      t.integer :planting_project_id
      t.integer :rental_status
      t.integer :status

      t.timestamps
    end
  end
end
