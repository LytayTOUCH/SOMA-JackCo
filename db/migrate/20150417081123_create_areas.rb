class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name

      t.timestamps
    end
  end
end
