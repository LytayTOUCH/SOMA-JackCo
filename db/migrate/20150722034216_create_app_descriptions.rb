class CreateAppDescriptions < ActiveRecord::Migration
  def change
    create_table :app_descriptions, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 255, null: false
      t.string :app_id, limit: 36, null: false

      t.timestamps
    end
  end
end
