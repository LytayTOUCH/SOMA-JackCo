class CreateFarms < ActiveRecord::Migration
  def change
    create_table :farms, :id => false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name
      t.string :location
      t.string :latlong_farm

      t.timestamps
    end
  end
end
