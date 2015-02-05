class CreateJackFruits < ActiveRecord::Migration
  def change
    create_table :jack_fruits, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :code, limit: 50, null: false
      t.string :status, limit: 30, null: false
      t.string :jack_fruit_type, limit: 30, null: false
      t.date :growing_date
      t.string :field_uuid, limit: 36, null: false
      t.string :stage_uuid, limit: 36, null: false
      t.text :note

      t.timestamps
    end
  end
end
