class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :period, limit: 30, null: false
      t.text :note

      t.timestamps
    end
  end
end
