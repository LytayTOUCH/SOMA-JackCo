class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.date :date, null: false
      t.text :note
      t.string :activity_type_uuid, limit: 36, null: false

      t.timestamps
    end
  end
end
