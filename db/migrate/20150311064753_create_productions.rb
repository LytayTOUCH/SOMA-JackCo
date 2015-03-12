class CreateProductions < ActiveRecord::Migration
  def change
    create_table :productions, id: false do |t|
      t.string :uuid, limit: 36, primary: true, null: false
      t.string :status, limit: 20, null: false
      t.string :planting_project_id, limit: 36, null: false
      t.string :uom_id, limit: 36, null: false
      t.text :note

      t.timestamps
    end
  end
end
