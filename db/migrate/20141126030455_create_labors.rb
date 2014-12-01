class CreateLabors < ActiveRecord::Migration
  def change
    create_table :labors, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :name, limit: 50, null: false
      t.string :position_uuid, limit: 36, null: false
      t.text :description
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
