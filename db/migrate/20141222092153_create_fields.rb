class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields, id: false do |t|
      t.string  :uuid, limit: 36, primary: true, null: false
      t.string  :name, limit: 100, null: false
      t.float   :size, limit: 100, null: false
      t.string  :address
      t.text    :note
      t.binary  :lat_long, null: false

      t.timestamps
    end
  end
end
