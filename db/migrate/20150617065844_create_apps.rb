class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :app_type, limit: 50, null: false
      t.text :note
      t.string :planting_project_id, limit: 36, null: false

      t.timestamps
    end
  end
end
