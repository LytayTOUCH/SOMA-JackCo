class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :user_id, limit: 36, null: false
      t.string :user_name
      t.string :note
      t.text :object

      t.timestamps
    end
  end
end
