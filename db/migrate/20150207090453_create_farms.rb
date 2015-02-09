class CreateFarms < ActiveRecord::Migration
  def change
    create_table :farms do |t|
      t.string :name
      t.string :location
      t.string :latlong_farm

      t.timestamps
    end
  end
end
