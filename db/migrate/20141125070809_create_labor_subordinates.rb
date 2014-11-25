class CreateLaborSubordinates < ActiveRecord::Migration
  def change
    create_table :labor_subordinates, id: false do |t|
      t.string :labor_uuid, limit: 36, null: false
      t.string :subordinate_uuid, limit: 36, null: false

      t.timestamps
    end
  end
end
