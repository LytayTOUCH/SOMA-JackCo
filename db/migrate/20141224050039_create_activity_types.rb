class CreateActivityTypes < ActiveRecord::Migration
  def change
    create_table :activity_types, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50
      t.text :note
      
      t.timestamps
    end
  end
end
